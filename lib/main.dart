import 'package:codesync/firebase_options.dart';
import 'package:codesync/presentation/auth_view/sign_up_screen.dart';
import 'package:codesync/provider/feature_provider/auth_provider.dart';

import 'package:codesync/provider/feature_provider/user_info_provider.dart';
import 'package:codesync/provider/ui_provider/bottom_nvaigation_provider.dart';

import 'package:codesync/provider/ui_provider/on_boarding_provider.dart';
import 'package:codesync/provider/ui_provider/password_hide_provider.dart';
import 'package:codesync/provider/ui_provider/theme_provider.dart';
import 'package:codesync/routes/app_raoutes.dart' show Routes;
import 'package:codesync/routes/route_names.dart' show AppRouteName;
import 'package:codesync/theme/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ChangeNotifierProvider<BottomNvaigationProvider>(
          create: (_) => BottomNvaigationProvider(),
        ),
        ChangeNotifierProvider<UserInfoProivder>(
          create: (_) => UserInfoProivder(),
        ),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<PasswordHideProvider>(
          create: (_) => PasswordHideProvider(),
        ),
        ChangeNotifierProvider<AuthentactionProvider>(
          create: (_) => AuthentactionProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            theme: CustomTheme.lightTheme,
            darkTheme: CustomTheme.darkTheme,
            themeMode: themeProvider.currentTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouteName.splashScreen,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}
