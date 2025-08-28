import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/domain/repositories/job_repository.dart';

class AddReview {
  final JobRepository repository;

  AddReview(this.repository);

  Future<Either<Failure, String>> execute(
    String jobId,
    int rating,
    String review,
  ) async {
    return await repository.addReview(jobId, rating, review);
  }
}
