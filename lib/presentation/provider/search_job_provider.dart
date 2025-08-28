import 'package:flutter/material.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/data/models/job.dart';
import 'package:jobbiez/domain/usecases/search_job.dart';

class SearchJobProvider extends ChangeNotifier {
  final SearchJob searchJob;

  SearchJobProvider({required this.searchJob});

  List<Job> _jobs = [];
  List<Job> get jobs => _jobs;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? _message;
  String? get message => _message;

  Future<List<Job>> getSearchJobs(
    String? jobTitle,
    String? jobCategory,
    String? jobType,
  ) async {
    _state = RequestState.Loading;
    notifyListeners();

    final safeJobTitle = jobTitle ?? "";
    final safeJobCategory = jobCategory ?? "";
    final safeJobType = jobType ?? "";

    final result = await searchJob.execute(
      safeJobTitle,
      safeJobCategory,
      safeJobType,
    );

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
