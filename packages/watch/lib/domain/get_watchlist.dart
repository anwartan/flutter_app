import 'package:core/core.dart';
import 'package:core/domain/entities/watch.dart';
import 'package:core/domain/repositories/watch_repository.dart';
import 'package:dartz/dartz.dart';

class GetWatchlist {
  final WatchRepository _repository;

  GetWatchlist(this._repository);

  Future<Either<Failure, List<Watch>>> execute() {
    return _repository.getWatchlist();
  }
}
