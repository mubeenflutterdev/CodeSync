import 'package:codesync/const/app_colors.dart';
import 'package:codesync/const/app_images.dart';
import 'package:codesync/presentation/auth_view/login_screen.dart';
import 'package:codesync/presentation/user_view/api_screen.dart';
import 'package:codesync/widgets/buttons/button_component.dart';
import 'package:codesync/widgets/input_fields/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 100.h),

              Image.asset(AppImages.loginImage),

              Text('Sign Up to your account'),
              SizedBox(height: 30.h),

              TextFormFieldComponent(
                hintText: 'Username',
                prefixIcon: Icons.person,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  return null;
                },
                controller: userNameControler,
              ),
              SizedBox(height: 20.h),
              TextFormFieldComponent(
                hintText: 'Email',
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  return null;
                },
                controller: emailControler,
              ),
              SizedBox(height: 20.h),
              TextFormFieldComponent(
                hintText: 'Password',
                prefixIcon: Icons.lock,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  return null;
                },
                controller: passwordControler,
              ),

              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ButtonComponent(
                  text: 'Sign Up',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ApiScreen()),
                      );
                    } else {
                      print("Validation failed");
                    }
                  },
                ),
              ),
              SizedBox(height: 70.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Have an account? ', style: TextStyle()),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
