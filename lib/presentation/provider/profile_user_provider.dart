import 'package:flutter/material.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/data/models/user.dart';
import 'package:jobbiez/domain/usecases/profile_user.dart';

class ProfileUserProvider extends ChangeNotifier {
  final ProfileUser profileUser;

  ProfileUserProvider({required this.profileUser});

  User? _user;
  User? get user => _user;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? _message;
  String? get message => _message;

  Future<User?> getProfileUser() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await profileUser.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        _user = null;
        notifyListeners();
      },
      (userData) {
        _state = RequestState.Loaded;
        _user = userData;
        notifyListeners();
      },
    );

    return _user;
  }
}
