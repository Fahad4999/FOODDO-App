import 'package:flutter/material.dart';
import 'package:fooddo_delivery/services.dart';
import 'package:splashscreen/splashscreen.dart' as Splash;

import 'login.dart';
import 'home.dart';

class SplashScreen extends StatelessWidget {
  Future<Widget> checkIfLoggedIn(BuildContext context) async {
    bool isLoggedIn = await Services.checkIfLoggedIn();
    if (isLoggedIn) {
      await Services.fetchUser();
      return Home();
    } else
      return Login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Splash.SplashScreen(
        navigateAfterSeconds: 20,
        navigateAfterFuture: checkIfLoggedIn(context),
        backgroundColor: Colors.white,
        photoSize: 200.0,
        loaderColor: Colors.blue,
        image: Image.asset("lib/assets/fooddo_logo.png"),
      ),
    );
  }
}
