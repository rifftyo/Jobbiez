import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/domain/usecases/update_profile.dart';

class UpdateProfileProvider extends ChangeNotifier {
  final UpdateProfile updateProfile;

  UpdateProfileProvider({required this.updateProfile});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? _message;
  String? get message => _message;

  File? _fotoProfileFile;
  File? get fotoProfileFile => _fotoProfileFile;

  String? _fotoProfileName;
  String? get fotoProfileName => _fotoProfileName;

  Future<void> pickFile() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      _fotoProfileFile = File(pickedFile.path);
      _fotoProfileName = pickedFile.path.split('/').last;
      notifyListeners();
    }
  }

  void resetPickedFile() {
    _fotoProfileFile = null;
    _fotoProfileName = null;
    notifyListeners();
  }

  Future<String> fetchUpdateProfile(String? username) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await updateProfile.execute(username, _fotoProfileFile);

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (success) {
        _state = RequestState.Loaded;
        _message = success;
        notifyListeners();
      },
    );

    return _message!;
  }
}
