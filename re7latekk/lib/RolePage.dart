import 'package:flutter/material.dart';
import 'package:re7latekk/SignInOrSignUp.dart';

void main() {
  runApp(const RolePage());
}

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: const [
            ChoseUser(),
          ],
        ),
      ),
    );
  }
}

class ChoseUser extends StatelessWidget {
  const ChoseUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 430,
          height: 932,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              const Positioned(
                left: 0,
                top: 91,
                child: SizedBox(width: 430, height: 905),
              ),
              Positioned(
                left: 125,
                top: 580,
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
                          left: 61,
                          top: 12,
                          child: SizedBox(
                            width: 59,
                            child: Text(
                              'USER',
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
                          left: 39,
                          top: 12,
                          child: SizedBox(
                            width: 114,
                            child: Text(
                              'COMPANY',
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
              Positioned(
                left: 0,
                top: 70,
                child: Container(
                  width: 430,
                  height: 430,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Images/RolePage.jpeg'),
                      fit: BoxFit.fill,
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
