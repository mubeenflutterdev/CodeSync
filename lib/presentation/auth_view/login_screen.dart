// ignore_for_file: avoid_print

import 'package:codesync/const/app_colors.dart';
import 'package:codesync/const/app_images.dart';
import 'package:codesync/presentation/auth_view/forget_password_screen.dart';
import 'package:codesync/presentation/user_view/api_screen.dart';
import 'package:codesync/provider/feature_provider/auth_provider.dart';
import 'package:codesync/routes/route_names.dart';
import 'package:codesync/widgets/buttons/button_component.dart';
import 'package:codesync/widgets/input_fields/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();

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
                'Sign in to your account',
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
                fieldType: FieldType.password,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 32.w, top: 5.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Forget Password ?',
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontSize: 12,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Consumer<AuthentactionProvider>(
                  builder: (context, provider, child) {
                    return ButtonComponent(
                      text: 'SignIn',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          final email = userNameControler.text.trim();
                          final password = passwordControler.text.trim();
                          provider.signInUser(context, email, password);
                        } else {
                          print("Validation failed");
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 30.h),

              ///  sign in section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.black)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        'Or Sign In with',
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.black)),
                  ],
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
                    'Don’t have an account? ',
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouteName.signupScreen);
                    },
                    child: Text(
                      'Sign Up',
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
