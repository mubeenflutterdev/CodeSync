// ignore_for_file: avoid_print

import 'package:codesync/const/app_colors.dart';
import 'package:codesync/const/app_images.dart';
import 'package:codesync/presentation/auth_view/otp_screen.dart';
import 'package:codesync/utils/dialog/sucess_dialog.dart';
import 'package:codesync/widgets/buttons/button_component.dart';
import 'package:codesync/widgets/input_fields/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChnagePasswordScreen extends StatefulWidget {
  const ChnagePasswordScreen({super.key});

  @override
  State<ChnagePasswordScreen> createState() => _ChnagePasswordScreenState();
}

class _ChnagePasswordScreenState extends State<ChnagePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController newPasswordControler = TextEditingController();
  TextEditingController confirmNewPasswordControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80.h),

              Image.asset(AppImages.changePasswordImage),
              SizedBox(height: 20.h),

              Text(
                'Change Password',
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 20.h),

              SizedBox(height: 40.h),

              TextFormFieldComponent(
                hintText: 'New Password',
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  } else {
                    print("Validation failed");
                  }
                  return null;
                },
                controller: confirmNewPasswordControler,
              ),
              SizedBox(height: 40.h),

              TextFormFieldComponent(
                hintText: 'Confirm New Password',
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  } else {
                    print("Validation failed");
                  }
                  return null;
                },
                controller: confirmNewPasswordControler,
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ButtonComponent(
                  text: 'Continue',
                  onTap: () {
                    String forgetEmail = confirmNewPasswordControler.text
                        .toString();
                    if (formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PasswordChangedDialog();
                        },
                      );
                    } else {
                      print("Validation failed");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
