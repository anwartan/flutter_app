import 'package:core/core.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';


class GetEpisodeTv {
  final TvRepository repository;

  GetEpisodeTv(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int idTv, int idSeason) {
    return repository.getTvEpisodeBySeason(idTv, idSeason);
  }
}
