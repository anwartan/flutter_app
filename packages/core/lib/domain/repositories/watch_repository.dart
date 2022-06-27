import 'package:core/core.dart';
import 'package:core/domain/entities/watch.dart';
import 'package:dartz/dartz.dart';


abstract class WatchRepository {
  Future<Either<Failure, String>> saveWatchlist(Watch watch);
  Future<Either<Failure, String>> removeWatchlist(Watch movie);
  Future<bool> isAddedToWatchlist(int refId, Type type);
  Future<Either<Failure, List<Watch>>> getWatchlist();
}
