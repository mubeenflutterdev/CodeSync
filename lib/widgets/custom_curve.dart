// ignore_for_file: must_be_immutable

import 'package:codesync/const/app_colors.dart';
import 'package:flutter/material.dart';

class CurvedTopBackground extends StatelessWidget {
  double height;
  CurvedTopBackground({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopDeepCurveClipper(),
      child: Container(
        height: height,
        width: double.infinity,
        color: AppColors.lightBackgroundColor,
      ),
    );
  }
}

class TopDeepCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 130); // deeper start
    path.quadraticBezierTo(
      size.width / 2,
      0, // dip point
      size.width,
      130, // end of the curve
    );
    path.lineTo(size.width, size.height); // right down
    path.lineTo(0, size.height); // left down
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
