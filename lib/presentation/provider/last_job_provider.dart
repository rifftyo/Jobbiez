import 'package:flutter/material.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/data/models/job.dart';
import 'package:jobbiez/domain/usecases/last_job.dart';

class LastJobProvider extends ChangeNotifier {
  final LastJob lastJob;

  LastJobProvider({required this.lastJob});

  List<Job> _jobs = [];
  List<Job> get jobs => _jobs;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? _message;
  String? get message => _message;

  Future<List<Job>> getLastJobs(String type) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await lastJob.execute(type);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (jobData) {
        _state = RequestState.Loaded;
        _jobs = jobData;
        notifyListeners();
      },
    );

    return _jobs;
  }
}
