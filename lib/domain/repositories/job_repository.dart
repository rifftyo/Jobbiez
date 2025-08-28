import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/data/models/application_response.dart';
import 'package:jobbiez/data/models/job.dart';
import 'package:jobbiez/data/models/job_detail.dart';

abstract class JobRepository {
  Future<Either<Failure, List<Job>>> getTopJobs();
  Future<Either<Failure, List<Job>>> getLastJobs(String type);
  Future<Either<Failure, List<Job>>> getSearchJob(
    String? jobTitle,
    String? jobCategory,
    String? jobType,
  );
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, JobDetail>> getJobDetail(String id);
  Future<Either<Failure, String>> addReview(
    String jobId,
    int rating,
    String review,
  );
  Future<Either<Failure, String>> applyJob(
    String jobId,
    String firstname,
    String lastname,
    String email,
    String phone,
    String country,
    String expectedSalary,
    String shortMessage,
    File cvFile,
  );
  Future<Either<Failure, List<Applications>>> getApplications();
}
