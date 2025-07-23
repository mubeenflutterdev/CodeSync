import 'package:codesync/const/app_images.dart';
import 'package:codesync/presentation/auth_view/login_screen.dart';
import 'package:flutter/material.dart';

class OnBoardingProvider with ChangeNotifier {
  int currentIndex = 0;
  final pageControler = PageController();

  final List<Map<String, String>> pages = [
    {
      'image': AppImages.onBoardingImages1,
      'title': 'Apply for courses and find jobs to grow your career',
      'desc':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ',
    },
    {
      'image': AppImages.onBoardingImages2,
      'title': 'Track All Activity And Daily Test',
      'desc': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'image': AppImages.onBoardingImages3,
      'title': 'Apply for courses and find jobs to grow your career',
      'desc': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
  ];
  void nextPage(BuildContext context) {
    if (currentIndex < pages.length - 1) {
      pageControler.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      /// here we will send user to next section login etc
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      print('Pressed');
    }
  }

  void skip(BuildContext context) {
    /// skiping next  onboarding and go to next section etc
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
