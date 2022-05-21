import 'package:core/core.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:dartz/dartz.dart';


abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingOnTv();
  Future<Either<Failure, List<Tv>>> getPopularOnTv();
  Future<Either<Failure, List<Tv>>> searchOnTv(String query);
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Episode>>> getTvEpisodeBySeason(
      int idTv, int idSeason);

  Future<Either<Failure, List<Tv>>> getTopRatedOnTv();
}
