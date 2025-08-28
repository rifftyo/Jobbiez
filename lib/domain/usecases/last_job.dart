import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/data/models/job.dart';
import 'package:jobbiez/domain/repositories/job_repository.dart';

class LastJob {
  final JobRepository repository;

  LastJob(this.repository);

  Future<Either<Failure, List<Job>>> execute(String type) {
    return repository.getLastJobs(type);
  }
}