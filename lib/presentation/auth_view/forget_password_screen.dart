import 'package:codesync/const/app_colors.dart';
import 'package:codesync/const/app_images.dart';
import 'package:codesync/presentation/auth_view/otp_screen.dart';
import 'package:codesync/widgets/buttons/button_component.dart';
import 'package:codesync/widgets/input_fields/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController forgetControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 90.h),

              Image.asset(AppImages.forgetImage),
              SizedBox(height: 20.h),

              Text(
                'Forgot password',
                style: TextStyle(
                  color: AppColors.textBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 59.w),
                child: Text(
                  'Enter your Email associated with your account we will send you a link to reset  your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(height: 40.h),

              TextFormFieldComponent(
                hintText: 'Email',
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  } else {
                    print("Validation failed");
                  }
                },
                controller: forgetControler,
              ),
              SizedBox(height: 60.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ButtonComponent(
                  text: 'Continue',
                  onTap: () {
                    String forgetEmail = forgetControler.text.toString();
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OtpScreen(forgetEmail: forgetEmail),
                        ),
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
