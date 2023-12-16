// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:re7latekk/CarListCarView.dart';

class CarForm extends StatefulWidget {
  const CarForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CarFormState createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _maintenanceController = TextEditingController();
  final TextEditingController _rentalController = TextEditingController();
  final TextEditingController _insuranceController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _NumOfPassController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
    // ignore: use_build_context_synchronously
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 16.0),
              Text(
                'Image added successfully!',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "ADD CAR",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 121, 121, 121)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 121, 121, 121)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CarListScreen(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        height: 170,
                        width: double.infinity,
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          await _pickImage();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Background color
                          onPrimary: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.image,
                                  color: Colors.white), // Icon before text
                              SizedBox(width: 8),
                              Text(
                                'Pick Image',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                const SizedBox(height: 16),
                FieldWidget(
                    controller: _modelController, hint: "Enter Car Model"),
                FieldWidget(
                    controller: _NumOfPassController,
                    hint: "Enter Number of passengers"),
                FieldWidget(
                    controller: _maintenanceController,
                    hint: "Enter maintenance report"),
                FieldWidget(
                    controller: _rentalController, hint: "Enter rental price"),
                FieldWidget(
                    controller: _insuranceController,
                    hint: "Enter insurance information"),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _addCar();

                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarListScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF045F91), // Background color
                    onPrimary: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: SizedBox(
                    width: 130, // Set the width to fill the parent
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 35),
                      child: const Text("ADD CAR"),
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

  void _addCar() async {
    if (_formKey.currentState!.validate()) {
      // All fields are valid, proceed to add the car
      try {
        String currentUserId = FirebaseAuth.instance.currentUser!.uid;
        DocumentReference carRef =
            await FirebaseFirestore.instance.collection('cars').add({
          'model': _modelController.text,
          'maintenance': _maintenanceController.text,
          'rental': _rentalController.text,
          'insurance': _insuranceController.text,
          'passengers': _NumOfPassController.text,
          // ignore: prefer_null_aware_operators
          'image_url': _imageFile != null ? _imageFile!.path : null,
          'addedBy': currentUserId,
        });

        // Reset the form after adding a car
        _formKey.currentState!.reset();
        _maintenanceController.clear();
        _modelController.clear();
        _rentalController.clear();
        _insuranceController.clear();
        _NumOfPassController.clear();
        _imageFile = null;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Car added successfully'),
        ));

        // Only navigate to CarListScreen if all text fields are filled
        if (_modelController.text.isNotEmpty &&
            _maintenanceController.text.isNotEmpty &&
            _rentalController.text.isNotEmpty &&
            _insuranceController.text.isNotEmpty &&
            _NumOfPassController.text.isNotEmpty) {}
      } catch (error) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error adding car: $error'),
        ));
      }
    }
  }
}

class FieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const FieldWidget({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black), // Set text color to black
        decoration: InputDecoration(
          fillColor: Colors.grey[100],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required Field';
          }
          return null;
        },
      ),
    );
  }
}
