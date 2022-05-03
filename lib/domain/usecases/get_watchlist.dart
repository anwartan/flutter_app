import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/watch.dart';
import 'package:ditonton/domain/repositories/watch_repository.dart';

class GetWatchlist {
  final WatchRepository _repository;

  GetWatchlist(this._repository);

  Future<Either<Failure, List<Watch>>> execute() {
    return _repository.getWatchlist();
  }
}
