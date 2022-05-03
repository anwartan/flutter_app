import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingOnTv();
  Future<Either<Failure, List<Tv>>> getPopularOnTv();
  Future<Either<Failure, List<Tv>>> getTopRatedOnTv();
  Future<Either<Failure, List<Tv>>> searchOnTv(String query);
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Episode>>> getTvEpisodeBySeason(
      int idTv, int idSeason);
}
