import 'package:core/core.dart';
import 'package:core/domain/entities/auth.dart';
import 'package:core/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUser{
  final AuthRepository authRepository;

  GetCurrentUser(this.authRepository);
  Future<Either<Failure, Auth?>> execute() {

    return authRepository.currentUser();
  }
}