import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/data/models/job.dart';
import 'package:jobbiez/domain/repositories/job_repository.dart';

class SearchJob {
  final JobRepository repository;

  SearchJob(this.repository);

  Future<Either<Failure, List<Job>>> execute(
    String? jobTitle,
    String? jobCategory,
    String? jobType,
  ) {
    return repository.getSearchJob(jobTitle, jobCategory, jobType);
  }
}