import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/domain/repositories/user_repository.dart';

class UpdateProfile {
  final UserRepository repository;

  UpdateProfile(this.repository);

  Future<Either<Failure, String>> execute(
    String? username,
    File? fotoProfile,
  ) async {
    return await repository.updateProfile(username, fotoProfile);
  }
}
