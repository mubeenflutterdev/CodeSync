import 'package:flutter/material.dart';

// password_hide_provider.dart


class PasswordHideProvider with ChangeNotifier {
  bool _passwordHidden = true;
  bool _confirmPasswordHidden = true;

  bool get isPasswordHidden => _passwordHidden;
  bool get isConfirmPasswordHidden => _confirmPasswordHidden;

  void togglePasswordVisibility() {
    _passwordHidden = !_passwordHidden;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _confirmPasswordHidden = !_confirmPasswordHidden;
    notifyListeners();
  }
}
