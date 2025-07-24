import 'package:codesync/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.white,
    cardColor: AppColors.green,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      /// using this for normal text
      titleMedium: TextStyle(color: AppColors.black, fontSize: 20.sp),

      titleSmall: TextStyle(
        color: AppColors.black,
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: AppColors.black,
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
      ),

      /// i am using this for hint text in text fields etc
      labelSmall: TextStyle(
        color: const Color.fromARGB(255, 85, 84, 84),
        fontSize: 13.sp,
        fontWeight: FontWeight.w300,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.white,
    cardColor: AppColors.green,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      titleLarge: GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 60.sp,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
