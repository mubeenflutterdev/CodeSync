import 'package:flutter/widgets.dart';

class ProfileProvider with ChangeNotifier {
  String gender = '';
  String adress = '';
  String phoneNumber = '';
  void changeGender(value) {
    gender = value;
    notifyListeners();
  }

  void chnageNumber(value) {
    phoneNumber = value;
    notifyListeners();
  }

  void changeAdress(value) {
    adress = value;
    notifyListeners();
  }
}
