import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/exception.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/data/datasources/remote_data_source.dart';
import 'package:jobbiez/data/models/application_response.dart';
import 'package:jobbiez/data/models/job.dart';
import 'package:jobbiez/data/models/job_detail.dart';
import 'package:jobbiez/domain/repositories/job_repository.dart';

class JobRepositoryImpl extends JobRepository {
  final RemoteDataSource remoteDataSource;

  JobRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Job>>> getTopJobs() async {
    try {
      final response = await remoteDataSource.getTopJobs();
      return right(response.data);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getLastJobs(String type) async {
    try {
      final response = await remoteDataSource.getLastJobs(type);
      return right(response.data);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getSearchJob(
    String? jobTitle,
    String? jobCategory,
    String? jobType,
  ) async {
    try {
      final response = await remoteDataSource.getSearchJob(
        jobTitle,
        jobCategory,
        jobType,
      );
      return right(response.data);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final response = await remoteDataSource.getCategories();
      return right(response.data);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, JobDetail>> getJobDetail(String id) async {
    try {
      final response = await remoteDataSource.getJobDetail(id);
      return right(response.jobDetail);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> addReview(
    String jobId,
    int rating,
    String review,
  ) async {
    try {
      final response = await remoteDataSource.addReview(jobId, rating, review);
      return right(response.message);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
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
  ) async {
    try {
      final response = await remoteDataSource.postApplyJob(
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
      return right(response.message);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Applications>>> getApplications() async {
    try {
      final response = await remoteDataSource.getApplications();
      return right(response.data);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
