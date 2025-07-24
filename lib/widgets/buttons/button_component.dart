import 'package:codesync/const/app_colors.dart';
import 'package:codesync/provider/feature_provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLogoutButton;

  const ButtonComponent({
    super.key,
    required this.text,
    required this.onTap,
    this.isLogoutButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthentactionProvider>(context);

    final isLoading =
        authProvider.isSignInLoading || authProvider.isSignUpLoading;

    return GestureDetector(
      onTap: () {
        if (!isLoading) {
          onTap(); // ✅ Only allow onTap if not loading
        }
      },
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isLogoutButton
                ? [Colors.red.shade400, Colors.red.shade600]
                : [Color.fromARGB(255, 41, 50, 56), Color(0xff174060)],
          ),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(
          child: isLogoutButton
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: AppColors.white),
                    SizedBox(width: 10.w),
                    Text(
                      text,
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                )
              : isLoading
              ? SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
