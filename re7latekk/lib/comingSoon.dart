import 'package:flutter/material.dart';
import 'package:re7latekk/SignInOrSignUp.dart';

class coming_soon extends StatefulWidget {
  const coming_soon({Key? key});

  @override
  State<coming_soon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<coming_soon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // removes the shadow
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'Images/comingSoon.jpeg', // Replace with the actual path to your image
              height: 450, // Adjust the height as needed
              width: 450, // Adjust the width as needed
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: Color.fromARGB(255, 93, 185, 48),
            ),
            SizedBox(height: 20),
            Text(
              "Coming Soon!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 36,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            Positioned(
              left: 125,
              top: 650,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInSignUp_company()),
                  );
                },
                child: SizedBox(
                  width: 180,
                  height: 47,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 180,
                          height: 47,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF045F91),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 50,
                        top: 12,
                        child: SizedBox(
                          width: 114,
                          child: Text(
                            'LOG OUT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
