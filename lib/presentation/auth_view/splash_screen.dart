import 'dart:async';

import 'package:codesync/const/app_images.dart';
import 'package:codesync/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() async {
    await Future.delayed(Duration(seconds: 2)); // Optional splash delay

    User? user = FirebaseAuth.instance.currentUser;

    // 🔁 Try again if still null (for Web/Mobile cold starts)
    for (int i = 0; i < 5 && user == null; i++) {
      await Future.delayed(Duration(milliseconds: 300));
      user = FirebaseAuth.instance.currentUser;
    }

    if (user != null && user.emailVerified) {
      Navigator.pushReplacementNamed(context, AppRouteName.profileScreen);
    } else {
      Navigator.pushReplacementNamed(context, AppRouteName.logInScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.onBoardingImages1),
          RichText(text: TextSpan(children: [])),
        ],
      ),
    );
  }
}
