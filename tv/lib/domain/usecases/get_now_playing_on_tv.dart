import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetNowPlayingOnTv {
  final TvRepository repository;

  GetNowPlayingOnTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingOnTv();
  }
}
