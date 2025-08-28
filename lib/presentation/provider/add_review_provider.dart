import 'package:flutter/material.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/domain/usecases/add_review.dart';
import 'package:jobbiez/presentation/provider/job_detail_provider.dart';

class AddReviewProvider extends ChangeNotifier {
  final AddReview addReview;

  AddReviewProvider({required this.addReview});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String? _message;
  String? get message => _message;

  int _rating = 0;
  int get rating => _rating;

  void setRating(int rating) {
    _rating = rating;
    notifyListeners();
  }

  void reset() {
    _state = RequestState.Empty;
    _message = null;
    _rating = 0;
    notifyListeners();
  }

  Future<String> addJobReview(
    String jobId,
    int rating,
    String review,
    JobDetailProvider jobDetailProvider,
  ) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await addReview.execute(jobId, rating, review);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (success) async {
        _message = success;
        _state = RequestState.Loaded;

        await jobDetailProvider.getJobDetail(jobId);
        notifyListeners();
      },
    );
    return _message!;
  }
}
