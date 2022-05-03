import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetEpisodeTv {
  final TvRepository repository;

  GetEpisodeTv(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int idTv, int idSeason) {
    return repository.getTvEpisodeBySeason(idTv, idSeason);
  }
}
