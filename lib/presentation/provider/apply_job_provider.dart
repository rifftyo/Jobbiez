import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/domain/usecases/apply_job.dart';

class ApplyJobProvider extends ChangeNotifier {
  final ApplyJob applyJob;

  ApplyJobProvider({required this.applyJob});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? _message;
  String? get message => _message;

  String? _selectedSalary;
  String? get selectedSalary => _selectedSalary;

  File? _cvFile;
  File? get cvFile => _cvFile;

  String? _cvFileName;
  String? get cvFileName => _cvFileName;

  Future<String> apply(
    String jobId,
    String firstname,
    String lastname,
    String email,
    String phone,
    String country,
    String shortMessage,
  ) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await applyJob.execute(
      jobId,
      firstname,
      lastname,
      email,
      phone,
      country,
      _selectedSalary!,
      shortMessage,
      _cvFile!,
    );

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (success) {
        _message = success;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );

    return _message!;
  }

  Future<void> pickCV() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.isNotEmpty) {
      _cvFile = File(result.files.first.path!);
      _cvFileName = result.files.first.name;
      notifyListeners();
    }
  }

  void setSelectedSalary(String salary) {
    _selectedSalary = salary;
    notifyListeners();
  }

  void resetData() {
    _selectedSalary = null;
    _cvFile = null;
    _cvFileName = null;
    notifyListeners();
  }
}
