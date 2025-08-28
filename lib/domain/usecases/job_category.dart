import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/domain/repositories/job_repository.dart';

class JobCategory {
  final JobRepository repository;

  JobCategory(this.repository);

  Future<Either<Failure, List<String>>> getCategories() async {
    return repository.getCategories();
  }
}
