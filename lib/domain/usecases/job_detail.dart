import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/data/models/job_detail.dart';
import 'package:jobbiez/domain/repositories/job_repository.dart';

class DetailJob {
  final JobRepository repository;

  DetailJob(this.repository);

  Future<Either<Failure, JobDetail>> execute(String id) async {
    return repository.getJobDetail(id);
  }
}