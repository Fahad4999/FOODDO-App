import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddo_delivery/screens/donation_details.dart';
import 'package:fooddo_delivery/screens/login.dart';
import 'package:fooddo_delivery/screens/signup.dart';
import 'package:fooddo_delivery/screens/splash_screen.dart';
import 'package:fooddo_delivery/screens/completed_assignments.dart';

import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(243, 241, 239, 1.0),
        fontFamily: "Raleway",
      ),
      routes: {
        "/": (ctx) => SplashScreen(),
        Home.pageRoute: (ctx) => Home(),
        Login.pageRoute: (ctx) => Login(),
        // SignUp.pageRoute: (ctx) => SignUp(),
        DonationDetails.pageRoute: (ctx) => DonationDetails(),
        CompletedAssignments.pageRoute: (ctx) => CompletedAssignments(),
      },
    );
  }
}
