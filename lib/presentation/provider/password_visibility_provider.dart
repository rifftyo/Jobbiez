import 'package:flutter/material.dart';

class PasswordVisibilityProvider extends ChangeNotifier {
  bool _isPasswordInvisible = true;
  bool get isPasswordInvisible => _isPasswordInvisible;

  void togglePasswordVisibility() {
    _isPasswordInvisible = !_isPasswordInvisible;
    notifyListeners();
  }
}
