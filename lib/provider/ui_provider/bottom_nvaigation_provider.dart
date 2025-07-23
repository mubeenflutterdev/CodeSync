import 'package:flutter/material.dart';

class BottomNvaigationProvider with ChangeNotifier {
  int selectedIndex = 0;

  void setIndex(index) {
    selectedIndex = index;
    notifyListeners();
  }
}
