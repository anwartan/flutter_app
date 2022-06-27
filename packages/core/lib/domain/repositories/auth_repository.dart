import 'package:core/core.dart';
import 'package:core/domain/entities/auth.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository{
  Future<Either<Failure,bool>> login(Auth auth);
  Future<Either<Failure,bool>> logout();
  Future<Either<Failure,Auth?>> currentUser();
}