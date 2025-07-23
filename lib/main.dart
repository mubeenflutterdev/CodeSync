import 'package:codesync/presentation/user_view/on_boarding_screen.dart';
import 'package:codesync/provider/ui_provider/on_boarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OnBoardingProvider>(
          create: (_) => OnBoardingProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
