import 'package:flutter/material.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/data/models/application_response.dart';
import 'package:jobbiez/domain/usecases/my_applications.dart';

class MyApplicationsProvider extends ChangeNotifier {
  final MyApplications myApplications;

  MyApplicationsProvider({required this.myApplications});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? _message;
  String? get message => _message;

  List<Applications> _applications = [];
  List<Applications> get applications => _applications;

  Future<List<Applications>> fetchMyApplications() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await myApplications.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _applications = data;
        notifyListeners();
      },
    );

    return _applications;
  }
}
