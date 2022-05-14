import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/common/enum.dart';
import 'package:equatable/equatable.dart';

import 'watch.dart';

class TvDetail extends Equatable {
  TvDetail(
      {required this.backdropPath,
      required this.genres,
      required this.id,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.seasons,
      required this.overview,
      required this.posterPath,
      required this.originalName,
      required this.voteAverage});
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<Season> seasons;
  final String overview;
  final String? posterPath;
  final String? originalName;
  final double voteAverage;

  @override
  // TODO: implement props
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        numberOfEpisodes,
        numberOfSeasons,
        seasons,
        overview,
        posterPath,
        originalName,
        voteAverage
      ];

  Watch copyToWatch() => Watch.watchlist(
      refId: id,
      overview: overview,
      posterPath: posterPath,
      title: originalName,
      type: Type.TV);
}
