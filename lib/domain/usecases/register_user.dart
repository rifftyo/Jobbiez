import 'package:dartz/dartz.dart';
import 'package:jobbiez/common/failure.dart';
import 'package:jobbiez/domain/repositories/user_repository.dart';

class RegisterUser {
  final UserRepository repository;

  RegisterUser(this.repository);

  Future<Either<Failure, String>> execute(
    String username,
    String email,
    String noHp,
    String password,
  ) async {
    final result = await repository.register(username, email, noHp, password);
    return result.fold((failure) => Left(failure), (token) async {
      await repository.saveToken(token);
      return Right(token);
    });
  }
}
