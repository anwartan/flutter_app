import 'package:core/core.dart';
import 'package:core/domain/entities/auth.dart';
import 'package:core/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
class LoginUser{
  final AuthRepository repository;

  LoginUser(this.repository);
  Future<Either<Failure, bool>> execute(String email) {
    final Auth auth = Auth(email: email, accessTime: DateTime.now().add(const Duration(minutes: 5)));
    return repository.login(auth);
  }
}