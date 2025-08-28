import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/domain/repositories/user_repository.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, String>> execute(String email, String password) async {
    final result = await repository.login(email, password);
    return result.fold((failure) => left(failure), (token) async {
      await repository.saveToken(token);
      return right(token);
    });
  }
}
