import 'package:codesync/widgets/shimmer/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSccreenShimmer extends StatefulWidget {
  const ProfileSccreenShimmer({super.key});

  @override
  State<ProfileSccreenShimmer> createState() => _ProfileSccreenShimmerState();
}

class _ProfileSccreenShimmerState extends State<ProfileSccreenShimmer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerBox(
          height: 250.h,
          width: double.infinity,
          borderRadius: BorderRadius.circular(40),
        ),
        // SizedBox(height: 60.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: ShimmerBox(
            height: 250.h,
            width: double.infinity,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: ShimmerBox(
            height: 60.h,
            width: double.infinity,
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
      ],
    );
  }
}
