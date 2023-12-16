import 'package:flutter/material.dart';
import 'package:re7latekk/LogInCompany.dart';
import 'package:re7latekk/RolePage.dart';
import 'package:re7latekk/companyRegistration.dart';

void main() {
  runApp(const SignInSignUp_company());
}

class SignInSignUp_company extends StatelessWidget {
  const SignInSignUp_company({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // removes the shadow
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RolePage(),
                ),
              );
            },
          ),
        ),
        body: ListView(children: const [
          SignInSignUpCompany(),
        ]),
      ),
    );
  }
}

class SignInSignUpCompany extends StatelessWidget {
  const SignInSignUpCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 430,
          height: 932, // Adjust the height as needed
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              const Positioned(
                left: 0,
                top: 110,
                child: SizedBox(width: 430, height: 800), // Adjust the height
              ),
              Positioned(
                left: 0,
                top: 30,
                child: Container(
                  width: 430,
                  height: 430,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Images/SignInSignUp.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              /////////////////////////////////////////////
              Positioned(
                left: 125,
                top: 520,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const login_company(),
                      ),
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
                          left: 55,
                          top: 12,
                          child: SizedBox(
                            width: 114,
                            child: Text(
                              'SIGN IN',
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
              ///////////////////////////////////
              Positioned(
                left: 125,
                top: 590,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpCompany(),
                      ),
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
                          left: 39,
                          top: 12,
                          child: SizedBox(
                            width: 114,
                            child: Text(
                              '   SIGN UP',
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
      ],
    );
  }
}
