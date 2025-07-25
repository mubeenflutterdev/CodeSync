import 'package:codesync/const/app_colors.dart';
import 'package:codesync/const/app_images.dart';
import 'package:codesync/presentation/user_view/api_screen.dart';
import 'package:codesync/provider/feature_provider/auth_provider.dart';

import 'package:codesync/routes/route_names.dart';
import 'package:codesync/widgets/buttons/button_component.dart';
import 'package:codesync/widgets/input_fields/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 100.h),
              Image.asset(AppImages.loginImage),

              Text(
                'Sign Up to your account',
                style: theme.textTheme.titleSmall,
              ),
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
                fieldType: FieldType.password,
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
                child: Consumer<AuthentactionProvider>(
                  builder: (context, provider, child) {
                    return ButtonComponent(
                      isLoading: provider.isSignUpLoading,
                      text: 'Sign Up',
                      onTap: () {
                        final email = emailControler.text.trim();
                        final password = passwordControler.text.trim();
                        final name = userNameControler.text.trim();
                        if (formKey.currentState!.validate()) {
                          provider.signUpUser(context, email, password, name);
                        } else {
                          print("Validation failed");
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 30.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 56.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.grey),
                      ),
                      child: Center(
                        child: SvgPicture.asset(AppImages.facebookImage),
                      ),
                    ),
                  ),
                  SizedBox(width: 28.w),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 56.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.grey),
                      ),
                      child: Center(
                        child: SvgPicture.asset(AppImages.googleImage),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account? ',
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouteName.logInScreen);
                    },
                    child: Text(
                      'Sign In',
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
