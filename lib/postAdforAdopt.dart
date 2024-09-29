import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class PostAdPage extends StatefulWidget {
  @override
  _PostAdPageState createState() => _PostAdPageState();
}

class _PostAdPageState extends State<PostAdPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _adTitleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _selectedPetType;
  File? _image;
  bool _isLoading = false;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _submitAd() async {
    if (_formKey.currentState!.validate() &&
        _selectedPetType != null &&
        _image != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Upload image to Firebase Storage
        String imageUrl = await _uploadImageToFirebase();

        // Get current user
        User? user = FirebaseAuth.instance.currentUser;

        // Get the current time
        String dateTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

        // Save ad details to Firestore
        await FirebaseFirestore.instance.collection('AdoptPets').add({
          'adTitle': _adTitleController.text,
          'petType': _selectedPetType,
          'location': _locationController.text,
          'phone': _phoneController.text,
          'imageUrl': imageUrl,
          'postedBy': user?.uid,
          'datePosted': dateTime,
        });

        // Clear all fields and reset the form
        _adTitleController.clear();
        _locationController.clear();
        _phoneController.clear();
        setState(() {
          _selectedPetType = null;
          _image = null;
        });
        _formKey.currentState?.reset();

        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Ad posted successfully')));
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all fields and upload a photo')));
    }
  }

  Future<String> _uploadImageToFirebase() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('ad_images/$fileName');
    UploadTask uploadTask = storageReference.putFile(_image!);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post a Pet Adoption Ad')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _adTitleController,
                      decoration: InputDecoration(labelText: 'Ad Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an ad title';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedPetType,
                      items: ['Dog', 'Cat', 'Bird', 'Fish'].map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPetType = value;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Pet Type'),
                      validator: (value) =>
                          value == null ? 'Please select a pet type' : null,
                    ),
                    TextFormField(
                      controller: _locationController,
                      decoration:
                          InputDecoration(labelText: 'Location Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration:
                          InputDecoration(labelText: 'Telephone Number'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a telephone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    _image == null
                        ? Text('No image selected.')
                        : Image.file(_image!, height: 150, width: 150),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Upload Image'),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitAd,
                        child: Text('Post Ad'),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
