import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/watch.dart';
import 'package:ditonton/domain/repositories/watch_repository.dart';

class RemoveWatchlist {
  final WatchRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(Watch watch) {
    return repository.removeWatchlist(watch);
  }
}
