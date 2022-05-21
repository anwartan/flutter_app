import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class SearchOnTv {
  final TvRepository repository;

  SearchOnTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchOnTv(query);
  }
}
