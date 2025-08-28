import 'package:flutter/material.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/data/models/job_detail.dart';
import 'package:jobbiez/domain/usecases/job_detail.dart';

class JobDetailProvider extends ChangeNotifier {
  final DetailJob detailJob;

  JobDetailProvider({required this.detailJob});

  JobDetail? _jobDetail;
  JobDetail? get jobDetail => _jobDetail;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? message;
  String? get getMessage => message;

  Future<JobDetail?> getJobDetail(String id) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await detailJob.execute(id);

    result.fold(
      (failure) {
        _state = RequestState.Error;
        message = failure.message;
        notifyListeners();
      },
      (jobDetailData) {
        _state = RequestState.Loaded;
        _jobDetail = jobDetailData;
        notifyListeners();
      },
    );

    return _jobDetail;
  }
}
