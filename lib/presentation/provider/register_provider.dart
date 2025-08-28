import 'package:flutter/material.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/domain/usecases/register_user.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterUser registerUser;

  RegisterProvider({required this.registerUser});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? _message;
  String? get message => _message;

  Future<void> register(
    String username,
    String email,
    String noHp,
    String password,
  ) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await registerUser.execute(username, email, noHp, password);

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
