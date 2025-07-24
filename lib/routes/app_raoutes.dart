import 'package:codesync/presentation/auth_view/login_screen.dart';
import 'package:codesync/presentation/auth_view/sign_up_screen.dart';
import 'package:codesync/presentation/auth_view/splash_screen.dart';
import 'package:codesync/presentation/user_view/on_boarding_screen.dart';
import 'package:codesync/presentation/user_view/profile_view/profile_screen.dart';

import 'package:codesync/routes/route_names.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppRouteName.logInScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case AppRouteName.signupScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      //  MaterialPageRoute(
      //     builder: (context) => ChangeNotifierProvider(
      //         create: (BuildContext context) => LogInProvider(),
      //         child: LogInScreen(args: args)));
      case AppRouteName.onboardingScreen:
        return MaterialPageRoute(builder: (context) => OnBoardingScreen());
      case AppRouteName.profileScreen:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(child: Text("Something went wrong.")),
            );
          },
        );
    }
  }
}
