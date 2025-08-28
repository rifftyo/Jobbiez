import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/data/models/user.dart';
import 'package:jobbiez/domain/repositories/user_repository.dart';

class ProfileUser {
  final UserRepository repository;

  ProfileUser(this.repository);

  Future<Either<Failure, User>> execute() {
    return repository.getProfile();
  }
}
