import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/data/models/job.dart';
import 'package:jobbiez/domain/repositories/job_repository.dart';

class TopJob {
  final JobRepository repository;

  TopJob(this.repository);

  Future<Either<Failure, List<Job>>> execute() {
    return repository.getTopJobs();
  }
}
