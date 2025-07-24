import 'dart:async';

import 'package:codesync/const/app_images.dart';
import 'package:codesync/routes/route_names.dart';
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
    Timer(Duration(microseconds: 1), () {
      Navigator.pushNamed(context, AppRouteName.logInScreen);
    });
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
