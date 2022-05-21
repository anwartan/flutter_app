import 'package:core/core.dart';
import 'package:core/domain/entities/watch.dart';
import 'package:core/domain/repositories/watch_repository.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlist {
  final WatchRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(Watch watch) {
    return repository.saveWatchlist(watch);
  }
}
