import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobbiez/domain/usecases/check_auth_status.dart';

class AuthProvider extends ChangeNotifier {
  final CheckAuthStatus checkAuthStatus;

  AuthProvider({required this.checkAuthStatus});

  bool? _isLoggedIn;
  bool? get isLoggedIn => _isLoggedIn;

  Future<void> checkAuth() async {
    final result = await checkAuthStatus.execute();
    _isLoggedIn = result;

    if (!_isLoggedIn!) {
      await logout();
    }

    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    notifyListeners();

    const storage = FlutterSecureStorage();
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'token_expiry');
  }
}
