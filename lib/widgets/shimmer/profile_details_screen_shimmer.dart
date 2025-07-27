import 'package:codesync/widgets/shimmer/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailsSccreenShimmer extends StatefulWidget {
  const ProfileDetailsSccreenShimmer({super.key});

  @override
  State<ProfileDetailsSccreenShimmer> createState() =>
      _ProfileDetailsSccreenShimmerState();
}

class _ProfileDetailsSccreenShimmerState
    extends State<ProfileDetailsSccreenShimmer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // SizedBox(height: 60.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: ShimmerBox(
            height: 350.h,
            width: double.infinity,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: ShimmerBox(
            height: 350.h,
            width: double.infinity,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}
