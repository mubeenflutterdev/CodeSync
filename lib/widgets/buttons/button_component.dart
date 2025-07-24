// ignore_for_file: must_be_immutable

import 'package:codesync/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonComponent extends StatelessWidget {
  String text;
  VoidCallback onTap;
  bool isLogoutButton;
  ButtonComponent({
    super.key,
    required this.text,
    required this.onTap,
    this.isLogoutButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 41, 50, 56), Color(0xff174060)],
          ),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(
          child: isLogoutButton == true
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: AppColors.white),
                      SizedBox(width: 20.w),

                      Text(
                        text,
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : Text(
                  text,
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: AppColors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
