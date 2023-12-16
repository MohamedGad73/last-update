import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:re7latekk/RolePage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const GetStart());
}

class GetStart extends StatelessWidget {
  const GetStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 430,
              height: 932,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  const Positioned(
                    left: 87,
                    top: 554,
                    child: SizedBox(
                      width: 290,
                      height: 63,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '',
                              style: TextStyle(
                                color: Color(0xFF045F91),
                                fontSize: 24,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: 'RE7LETAK',
                              style: TextStyle(
                                color: Color(0xFF045F91),
                                fontSize: 36,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: ',\n Elevate your experience.\n',
                              style: TextStyle(
                                color: Color(0xFF045F91),
                                fontSize: 24,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 125,
                    top: 710,
                    child: SizedBox(
                      width: 180,
                      height: 47,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the user_company page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RolePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF045F91),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'GET START',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 76,
                    child: Container(
                      width: 430,
                      height: 430,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('Images/getStart.jpeg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: SizedBox(
                      width: 430,
                      height: 27,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 430,
                              height: 27,
                              decoration:
                                  const BoxDecoration(color: Color(0xFF045F91)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
