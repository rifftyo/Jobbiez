import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/data/models/user.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, String>> register(
    String username,
    String email,
    String noHp,
    String password,
  );
  Future<Either<Failure, User>> getProfile();
  Future<Either<Failure, String>> updateProfile(
    String? username,
    File? fotoProfile,
  );
  Future<void> saveToken(String token);
  Future<String?> getTokenExpiry();
  Future<String?> getToken();
  Future<void> clearToken();
}
