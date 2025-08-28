import 'package:flutter/material.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/domain/usecases/login_user.dart';

class LoginProvider extends ChangeNotifier {
  final LoginUser loginUser;

  LoginProvider({required this.loginUser});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? _message;
  String? get message => _message;

  Future<void> login(String email, String password) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await loginUser.execute(email, password);

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (success) {
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
