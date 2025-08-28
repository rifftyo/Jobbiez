import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/data/models/application_response.dart';
import 'package:jobbiez/domain/repositories/job_repository.dart';

class MyApplications {
  final JobRepository repository;

  MyApplications(this.repository);

  Future<Either<Failure, List<Applications>>> execute() async {
    return await repository.getApplications();
  }
}
