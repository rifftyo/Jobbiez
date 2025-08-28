import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/domain/repositories/job_repository.dart';

class ApplyJob {
  final JobRepository repository;

  ApplyJob(this.repository);

  Future<Either<Failure, String>> execute(
    String jobId,
    String firstname,
    String lastname,
    String email,
    String phone,
    String country,
    String expectedSalary,
    String shortMessage,
    File cvFile,
  ) async {
    return await repository.applyJob(
      jobId,
      firstname,
      lastname,
      email,
      phone,
      country,
      expectedSalary,
      shortMessage,
      cvFile,
    );
  }
}
