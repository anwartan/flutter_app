

import 'package:core/core.dart';
import 'package:core/data/datasources/auth_data_source.dart';
import 'package:core/data/models/auth_model.dart';
import 'package:core/domain/entities/auth.dart';
import 'package:core/domain/repositories/auth_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository{

  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, Auth?>> currentUser() async {
    final result = await authDataSource.currentUser();
    return Right(result?.toEntity());
  }

  @override
  Future<Either<Failure, bool>> login(Auth auth) async {
    final result = await authDataSource.login(AuthModel.fromEntity(auth));
    return Right(result);
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    final result = await authDataSource.logout();
    return Right(result);
  }

}