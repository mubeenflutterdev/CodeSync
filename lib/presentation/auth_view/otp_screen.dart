import 'package:codesync/const/app_colors.dart';
import 'package:codesync/const/app_images.dart';
import 'package:codesync/presentation/auth_view/change_password_screen.dart';
import 'package:codesync/widgets/buttons/button_component.dart';
import 'package:codesync/widgets/input_fields/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  String forgetEmail;
  OtpScreen({super.key, required this.forgetEmail});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController demo = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 50.h),

              Image.asset(AppImages.oTPImage),
              SizedBox(height: 20.h),

              Text(
                'OTP VERIFICATION',
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 59.w),
                child: Text(
                  'Enter the code from the Email we sent to ${widget.forgetEmail}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              //// opt input section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(otpFocusNode);
                  },
                  child: PinCodeTextField(
                    focusNode: otpFocusNode,
                    appContext: context,
                    length: 6, // number of OTP digits
                    controller: demo, // your controller
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape:
                          PinCodeFieldShape.circle, // ⭕️ this makes it circular
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      selectedColor: AppColors.backgroundColor,
                      activeColor: AppColors.lightBackgroundColor,
                      inactiveColor: Colors.grey,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: false,
                    autoFocus: true,
                    onChanged: (value) {
                      print("OTP Value: $value");
                    },
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Enter complete OTP';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ButtonComponent(
                  text: 'Continue',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      // ✅ OTP is complete
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChnagePasswordScreen(),
                        ),
                      );
                      // Do verification here
                    } else {
                      // ❌ Incomplete OTP
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
