import 'package:core/core.dart';
import 'package:core/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUser{
  final AuthRepository authRepository;
  LogoutUser(this.authRepository);
  Future<Either<Failure, bool>> execute() {

    return authRepository.logout();
  }
}