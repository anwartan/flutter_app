import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedOnTv {
  final TvRepository repository;

  GetTopRatedOnTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedOnTv();
  }
}
