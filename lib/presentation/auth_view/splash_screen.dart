// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:codesync/const/app_images.dart';
import 'package:codesync/provider/ui_provider/on_boarding_provider.dart';
import 'package:codesync/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

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
    final storage = GetStorage();
    bool isSeen = storage.read('isSeen') ?? false;

    await Future.delayed(const Duration(seconds: 2)); // Optional splash delay

    // Wait for Firebase to emit the first auth state
    User? user = await FirebaseAuth.instance.authStateChanges().first;

    if (!mounted) return;

    if (user != null && user.emailVerified) {
      Navigator.pushReplacementNamed(context, AppRouteName.profileScreen);
    } else if (!isSeen) {
      Navigator.pushReplacementNamed(context, AppRouteName.onboardingScreen);
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
