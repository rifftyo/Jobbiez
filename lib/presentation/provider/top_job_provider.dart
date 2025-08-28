import 'package:flutter/material.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/data/models/job.dart';
import 'package:jobbiez/domain/usecases/top_job.dart';

class TopJobProvider extends ChangeNotifier {
  final TopJob topJob;

  TopJobProvider({required this.topJob});

  List<Job> _jobs = [];
  List<Job> get jobs => _jobs;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? _message;
  String? get message => _message;

  Future<List<Job>> getTopJobs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await topJob.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (jobsData) {
        _state = RequestState.Loaded;
        _jobs = jobsData;
        notifyListeners();
      },
    );

    return _jobs;
  }
}
