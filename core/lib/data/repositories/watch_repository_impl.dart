import 'package:core/core.dart';
import 'package:core/data/datasources/watch_local_data_source.dart';
import 'package:core/data/models/watch_table.dart';
import 'package:core/domain/entities/watch.dart';
import 'package:core/domain/repositories/watch_repository.dart';
import 'package:dartz/dartz.dart';


class WatchRepositoryImpl extends WatchRepository {
  final WatchLocalDataSource localDataSource;
  WatchRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Watch>>> getWatchlist() async {
    final result = await localDataSource.getWatchlist();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int refId, Type type) async {
    final result = await localDataSource.getWatchByIdAndType(refId, type);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(Watch watch) async {
    try {
      final result =
          await localDataSource.removeWatchlist(WatchTable.fromEntity(watch));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(Watch watch) async {
    try {
      final result =
          await localDataSource.insertWatchlist(WatchTable.fromEntity(watch));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }
}
