import 'package:jobbiez/domain/repositories/user_repository.dart';

class CheckAuthStatus {
  final UserRepository repository;

  CheckAuthStatus(this.repository);

  Future<bool> execute() async {
    final token = await repository.getToken();
    final expiry = await repository.getTokenExpiry();

    if (token == null || expiry == null) {
      return false;
    }

    final expiryDate = DateTime.parse(expiry);
    if (DateTime.now().isAfter(expiryDate)) {
      await repository.clearToken();
      return false;
    }

    return true;
  }
}
