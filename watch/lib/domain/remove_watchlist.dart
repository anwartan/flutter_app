import 'package:core/domain/entities/watch.dart';
import 'package:core/domain/repositories/watch_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class RemoveWatchlist {
  final WatchRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(Watch watch) {
    return repository.removeWatchlist(watch);
  }
}
