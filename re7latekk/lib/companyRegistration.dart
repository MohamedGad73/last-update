// ignore: file_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:re7latekk/addCarr.dart';

void main() {
  runApp(const SignUpCompany());
}

class SignUpCompany extends StatelessWidget {
  const SignUpCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: Colors.black),
      ),
      home: const Scaffold(
        body: RegistrationFields(),
      ),
    );
  }
}

class RegistrationFields extends StatefulWidget {
  const RegistrationFields({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationFieldsState createState() => _RegistrationFieldsState();
}

class _RegistrationFieldsState extends State<RegistrationFields> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? fullName, email, password, phoneNumber, taxNumber, address;

  String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  FormFieldValidator<String>? passwordValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  };

  Future<void> registerUser() async {
    // Validate all fields here
    String? fullNameError = validateField(fullName, 'full name');
    String? phoneNumberError = validateField(phoneNumber, 'phone number');
    String? taxNumberError = validateField(taxNumber, 'tax number');
    String? addressError = validateField(address, 'address');
    String? emailError = validateField(email, 'email');
    String? passwordError = passwordValidator!(password);

    if (fullNameError != null ||
        phoneNumberError != null ||
        taxNumberError != null ||
        addressError != null ||
        emailError != null ||
        passwordError != null) {
      // Display the first error message encountered
      String? errorMessage = fullNameError ??
          phoneNumberError ??
          taxNumberError ??
          addressError ??
          emailError ??
          passwordError;
      final snackBar = SnackBar(content: Text(errorMessage!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return; // Stop registration if any field is invalid
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CarForm()),
      );
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'full_name': fullName,
          'phoneNumber': phoneNumber,
          'taxNumber': taxNumber,
          'address': address,
          'email': email,
        });
      }
    } catch (e) {
      print(e);
      final snackBar =
          SnackBar(content: Text('Error registering user. ${e.toString()}'));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(color: Colors.grey, fontSize: 16);
    const inputStyle = TextStyle(color: Colors.black, fontSize: 18);

    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 330,
              height: 330, // Adjust the height as needed
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Images/SignUpCompany.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xFF164863),
                      fontSize: 28,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildGrayBoxTextField(
                    'FULL NAME',
                    labelStyle,
                    inputStyle,
                    onChanged: (value) {
                      setState(() {
                        fullName = value.trim();
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  buildGrayBoxTextField(
                    'PHONE NUMBER',
                    labelStyle,
                    inputStyle,
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  buildGrayBoxTextField(
                    'TAX NUMBER',
                    labelStyle,
                    inputStyle,
                    onChanged: (value) {
                      setState(() {
                        taxNumber = value;
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  buildGrayBoxTextField(
                    'ADDRESS',
                    labelStyle,
                    inputStyle,
                    onChanged: (value) {
                      setState(() {
                        address = value;
                      });
                    },
                    validator: (value) => validateField(value, 'address'),
                  ),
                  const SizedBox(height: 5),
                  buildGrayBoxTextField(
                    'EMAIL',
                    labelStyle,
                    inputStyle,
                    onChanged: (value) {
                      setState(() {
                        email = value.trim();
                      });
                    },
                    validator: (value) => validateField(value, 'email'),
                  ),
                  const SizedBox(height: 5),
                  buildGrayBoxTextField(
                    'PASSWORD',
                    labelStyle,
                    inputStyle,
                    obscureText: true,
                    validator: passwordValidator,
                    onChanged: (value) {
                      setState(() {
                        password = value.trim();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        await registerUser(); // Wait for registerUser to complete
                      },
                      child: Container(
                        width: 180,
                        height: 47,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          color: Color(0xFF045F91),
                        ),
                        child: const Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Widget buildGrayBoxTextField(
    String label,
    TextStyle labelStyle,
    TextStyle inputStyle, {
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      style: const TextStyle(color: Colors.black, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
    );
  }
}
