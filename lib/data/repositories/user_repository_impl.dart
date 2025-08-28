import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobbiez/common/exception.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/data/datasources/remote_data_source.dart';
import 'package:jobbiez/data/models/user.dart';
import 'package:jobbiez/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final response = await remoteDataSource.login(email, password);
      return right(response.accessKey);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> register(
    String username,
    String email,
    String noHp,
    String password,
  ) async {
    try {
      final response = await remoteDataSource.register(
        username,
        email,
        noHp,
        password,
      );
      return right(response.accessKey);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, User>> getProfile() async {
    try {
      final response = await remoteDataSource.getProfile();
      return right(response.data);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfile(
    String? username,
    File? fotoProfile,
  ) async {
    try {
      final response = await remoteDataSource.updateProfile(
        username,
        fotoProfile,
      );
      return right(response.message);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } on SocketException {
      return left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: "access_token");
  }

  @override
  Future<String?> getTokenExpiry() async {
    return await secureStorage.read(key: "token_expiry");
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: "access_token", value: token);
    await secureStorage.write(
      key: "token_expiry",
      value: DateTime.now().add(const Duration(days: 7)).toIso8601String(),
    );
  }

  @override
  Future<void> clearToken() async {
    await secureStorage.delete(key: "access_token");
  }
}
