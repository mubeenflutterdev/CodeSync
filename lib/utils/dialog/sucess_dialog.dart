import 'package:codesync/const/app_images.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class PasswordChangedDialog extends StatefulWidget {
  const PasswordChangedDialog({super.key});

  @override
  State<PasswordChangedDialog> createState() => _PasswordChangedDialogState();
}

class _PasswordChangedDialogState extends State<PasswordChangedDialog> {
  @override
  void initState() {
    super.initState();
    // Automatically close dialog after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF005BEA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.sucessImage),
            const SizedBox(height: 20),
            const Text(
              'Password changed!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Congratulation your password\nhas been changed',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
