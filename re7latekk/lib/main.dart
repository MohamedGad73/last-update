//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:re7latekk/CarListCarView.dart';
import 'package:re7latekk/SignInOrSignUp.dart';
import 'package:re7latekk/comingSoon.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'get_start.dart';
import 'companyRegistration.dart'; // Please ensure to create this file and keep your FigmaToCodeApp in it
import 'RolePage.dart'; // Please ensure to create this file and keep your FigmaToCodeApp in it

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: FirebaseAuth.instance.currentUser != null
      //     ? CarListScreen()
      //     :
      home: const GetStart(),
      routes: {
        '/GetStart': (BuildContext context) => const GetStart(),
        '/RolePage': (BuildContext context) => const RolePage(),
        '/SignInSignUp_company': (BuildContext context) =>
            const SignInSignUp_company(),
        '/SignUp_Company': (BuildContext context) => const SignUpCompany(),
        '/coming_soon': (BuildContext context) => const coming_soon(),
      },
    );
  }
}
