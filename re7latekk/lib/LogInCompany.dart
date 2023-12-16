import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:re7latekk/CarListCarView.dart';
import 'package:re7latekk/SignInOrSignUp.dart';

import 'package:re7latekk/companyRegistration.dart';

// ignore: camel_case_types
class login_company extends StatelessWidget {
  const login_company({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark().copyWith(
      //scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      //),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInSignUp_company(),
                ),
              );
            },
          ),
        ),
        body: logincompany(),
      ),
    );
  }
}

// ignore: must_be_immutable
class logincompany extends StatelessWidget {
  logincompany({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a form key

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    // Validate the form
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // Navigate to the next screen or perform other actions.
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CarListScreen(),
          ),
        );

        print("User signed in: ${userCredential.user!.uid}");
      } on FirebaseAuthException catch (e) {
        // Handle errors
        print("Error during sign in: ${e.message}");

        // Display an error message to the user
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Login Error"),
              content: Text(e.message ?? "An error occurred during login."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(color: Colors.black, fontSize: 17);
    const inputStyle = TextStyle(color: Colors.black, fontSize: 18);

    return Material(
      child: SingleChildScrollView(
        // Wrap the column with SingleChildScrollView
        child: Column(
          children: [
            Container(
              width: 430,
              height: 800,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.white),
              child: Form(
                key: _formKey, // Assign the form key to the form
                child: Column(
                  children: [
                    Container(
                      width: 430,
                      height: 350,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('Images/LogInCompany.jpeg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Material(
                            // Wrap TextField with Material widget
                            color: const Color.fromARGB(31, 167, 137, 137),
                            child: TextFormField(
                              controller: emailController,
                              style: inputStyle,
                              decoration: const InputDecoration(
                                labelText: "Email",
                                labelStyle: labelStyle,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          Material(
                            // Wrap TextField with Material widget
                            color: const Color.fromARGB(31, 167, 137, 137),
                            child: TextFormField(
                              controller: passwordController,
                              style: inputStyle,
                              decoration: const InputDecoration(
                                labelText: "Password",
                                labelStyle: labelStyle,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              signInWithEmailAndPassword(context);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFF045F91),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'SIGN IN',
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
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account ?",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 40, 46, 49),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpCompany(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Color(0xFF045F91),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
