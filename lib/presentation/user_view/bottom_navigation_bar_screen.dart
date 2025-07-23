import 'package:codesync/const/app_colors.dart';
import 'package:codesync/presentation/user_view/profile_view/profile_screen.dart';
import 'package:codesync/provider/ui_provider/bottom_nvaigation_provider.dart';
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
      decoration: BoxDecoration(color: AppColors.deepOrange),
      child: Text('1'),
    ),
    Container(
      decoration: BoxDecoration(color: AppColors.blue),
      child: Text('2'),
    ),
    Container(
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNvaigationProvider.selectedIndex,
        onTap: (index) {
          bottomNvaigationProvider.setIndex(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.abc)),
          BottomNavigationBarItem(icon: Icon(Icons.abc)),
          BottomNavigationBarItem(icon: Icon(Icons.abc)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
