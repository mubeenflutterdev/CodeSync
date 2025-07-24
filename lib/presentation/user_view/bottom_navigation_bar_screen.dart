import 'package:codesync/const/app_colors.dart';
import 'package:codesync/presentation/user_view/profile_view/profile_screen.dart';
import 'package:codesync/provider/ui_provider/bottom_nvaigation_provider.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  List screens = [
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: AppColors.deepOrange),
      child: Text('1'),
    ),
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: AppColors.blue),
      child: Text('2'),
    ),
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: AppColors.teal),
      child: Text('3'),
    ),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    BottomNvaigationProvider bottomNvaigationProvider =
        Provider.of<BottomNvaigationProvider>(context);
    return Scaffold(
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: bottomNvaigationProvider.selectedIndex,
        showElevation: true,
        onItemSelected: (index) {
          bottomNvaigationProvider.setIndex(index);
        },
        items: [
          FlashyTabBarItem(icon: Icon(Icons.event), title: Text('Events')),
          FlashyTabBarItem(icon: Icon(Icons.search), title: Text('Search')),
          FlashyTabBarItem(
            icon: Icon(Icons.highlight),
            title: Text('Highlights'),
          ),
          FlashyTabBarItem(icon: Icon(Icons.settings), title: Text('Settings')),
        ],
      ),

      body: screens[bottomNvaigationProvider.selectedIndex],
    );
  }
}
