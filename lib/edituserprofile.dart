import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Edituserprofile extends StatefulWidget {
  const Edituserprofile({super.key});

  @override
  State<Edituserprofile> createState() => _EdituserprofileState();
}

class _EdituserprofileState extends State<Edituserprofile> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _image; // Image file for the profile picture
  String? _imageUrl; // URL of the uploaded image

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      _nameController.text = userDoc['name'] ?? '';
      _emailController.text = user.email ?? '';
      _phoneController.text = userDoc['phone'] ?? '';
      _addressController.text = userDoc['address'] ?? '';
      _imageUrl = userDoc['imageUrl'] ?? ''; // Load existing image URL if available
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage(); // Upload image after picking it
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      try {
        // Create a reference to Firebase Storage
        User? user = _auth.currentUser;
        if (user != null) {
          String fileName = '${user.uid}/profile_pic.jpg';
          Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

          // Upload the file to Firebase Storage
          UploadTask uploadTask = storageRef.putFile(_image!);
          TaskSnapshot snapshot = await uploadTask;

          // Get the image URL after upload
          String downloadUrl = await snapshot.ref.getDownloadURL();

          setState(() {
            _imageUrl = downloadUrl; // Set the image URL
          });

          // Save the image URL to Firestore
          await _firestore.collection('users').doc(user.uid).update({
            'imageUrl': _imageUrl,
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image uploaded successfully!')));
        }
      } catch (error) {
        print('Error uploading image: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload image.')));
      }
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Reference to the user's document in the "users" collection
        DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

        // Data to update
        Map<String, dynamic> updatedData = {
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          if (_imageUrl != null) 'imageUrl': _imageUrl, // Update imageUrl if available
        };

        // Update the user document with the new data
        await userDocRef.update(updatedData);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));
      }
    } catch (error) {
      print('Error updating profile: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile. Please try again.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _image != null
                                ? FileImage(_image!) as ImageProvider
                                : _imageUrl != null && _imageUrl!.isNotEmpty
                                ? NetworkImage(_imageUrl!)
                                : AssetImage('assets/profile_placeholder.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage, // Pick image on tap
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 4, color: Colors.white),
                              color: Colors.blue,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField('Name', _nameController),
                const SizedBox(height: 17.0),
                _buildTextField('Email', _emailController),
                const SizedBox(height: 17.0),
                _buildTextField('Phone Number', _phoneController),
                const SizedBox(height: 17.0),
                _buildTextField('Address', _addressController),
                const SizedBox(height: 25.0),
                ElevatedButton(
                  onPressed: _updateUserProfile,
                  child: Text(
                    "Update Details",
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(label),
        hintText: 'Enter $label',
        hintStyle: const TextStyle(color: Colors.black26),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
