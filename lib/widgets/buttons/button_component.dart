// ignore_for_file: must_be_immutable

import 'package:codesync/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonComponent extends StatelessWidget {
  String text;
  VoidCallback onTap;
  ButtonComponent({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff3290D9), Color(0xff174060)],
          ),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
