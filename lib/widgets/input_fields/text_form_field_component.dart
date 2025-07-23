// ignore_for_file: must_be_immutable

import 'package:codesync/const/app_colors.dart';
import 'package:codesync/const/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldComponent extends StatelessWidget {
  String hintText;
  IconData prefixIcon;
  TextEditingController controller;
  final String? Function(String?)? validator;

  TextFormFieldComponent({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 13.sp),
          filled: true,
          fillColor: Colors.white,
          isDense: true,

          hintText: hintText,
          prefixIcon: Icon(prefixIcon, color: AppColors.backgroundColor),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 240, 238, 238),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(
              color: AppColors.backgroundColor,
              width: 1.5,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    );
  }
}
