import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/watch.dart';
import 'package:ditonton/presentation/pages/search_page.dart';

abstract class WatchRepository {
  Future<Either<Failure, String>> saveWatchlist(Watch watch);
  Future<Either<Failure, String>> removeWatchlist(Watch movie);
  Future<bool> isAddedToWatchlist(int refId, Type type);
  Future<Either<Failure, List<Watch>>> getWatchlist();
}
