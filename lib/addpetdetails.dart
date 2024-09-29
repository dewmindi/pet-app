import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class PetDetails extends StatefulWidget {
  @override
  State<PetDetails> createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? _petType;
  String? _petName;
  String? _petWeight;
  DateTime? _selectedDate;
  String? _petGender;
  bool _isDeviceConnected = false;
  String? _deviceName;
  String? _deviceId;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
    FirebaseStorage.instance.ref().child('pet_images/$fileName');

    UploadTask uploadTask = storageReference.putFile(_imageFile!);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Pets"),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                SizedBox(height: 20),
                _inputField(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          "Add Your Beloved Pet's Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: _imageFile != null
              ? Image.file(
            _imageFile!,
            height: 100,
            width: 150,
            fit: BoxFit.cover,
          )
              : Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.indigoAccent, width: 1),
              borderRadius: BorderRadius.circular(15)),
          child: DropDownButton1(
            onChanged: (value) {
              _petType = value;
            },
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: "Pet Name",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.indigoAccent.withOpacity(0.1),
            filled: true,
          ),
          onChanged: (value) {
            _petName = value;
          },
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: "Weight (KG)",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.indigoAccent.withOpacity(0.1),
            filled: true,
          ),
          onChanged: (value) {
            _petWeight = value;
          },
        ),
        SizedBox(height: 20),
        _buildDatePicker(context),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.indigoAccent, width: 1),
              borderRadius: BorderRadius.circular(15)),
          child: DropDownButton2(
            onChanged: (value) {
              _petGender = value;
            },
          ),
        ),
        SizedBox(height: 20),
        _buildDeviceToggle(),
        if (_isDeviceConnected) _buildDeviceFields(),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _addPetDetails(context);
          },
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.indigoAccent,
            foregroundColor: Colors.white,
          ),
          child: Text(
            "Add Pet",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  Future<void> _addPetDetails(BuildContext context) async {
    final User? user = _auth.currentUser;
    if (user != null && _petName != null && _petType != null) {
      String? imageUrl = await _uploadImage();

      Map<String, dynamic> petData = {
        'petName': _petName,
        'petType': _petType,
        'petWeight': _petWeight,
        'petBirthDate': _selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
            : null,
        'petGender': _petGender,
        'imageUrl': imageUrl, // Store image URL
        'ownerId': user.uid,
        'addedOn': DateTime.now(),
      };

      if (_isDeviceConnected) {
        petData.addAll({
          'deviceName': _deviceName,
          'deviceId': _deviceId,
        });
      }

      await _firestore.collection('pets').add(petData);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pet details added successfully!'),
        backgroundColor: Colors.green,
      ));

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all required fields'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget _buildDeviceToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Connect to a Device", style: TextStyle(fontSize: 16)),
        Switch(
          value: _isDeviceConnected,
          onChanged: (value) {
            setState(() {
              _isDeviceConnected = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDeviceFields() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Device Name",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.indigoAccent.withOpacity(0.1),
            filled: true,
          ),
          onChanged: (value) {
            _deviceName = value;
          },
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: "Device ID",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.indigoAccent.withOpacity(0.1),
            filled: true,
          ),
          onChanged: (value) {
            _deviceId = value;
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: "Select Date of Birth",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.indigoAccent.withOpacity(0.1),
          filled: true,
        ),
        child: Text(
          _selectedDate != null
              ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
              : 'Select Date of Birth',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class DropDownButton1 extends StatelessWidget {
  final Function(String?) onChanged;

  const DropDownButton1({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: ['Dog', 'Cat', 'Bird'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: Text("Select Pet Type"),
      onChanged: onChanged,
    );
  }
}

class DropDownButton2 extends StatelessWidget {
  final Function(String?) onChanged;

  const DropDownButton2({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: ['Male', 'Female'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: Text("Select Gender"),
      onChanged: onChanged,
    );
  }
}
