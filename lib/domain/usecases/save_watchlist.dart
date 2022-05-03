import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/watch.dart';
import 'package:ditonton/domain/repositories/watch_repository.dart';

class SaveWatchlist {
  final WatchRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(Watch watch) {
    return repository.saveWatchlist(watch);
  }
}
