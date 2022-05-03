import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
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
  String? backdropPath;
  List<Genre> genres;
  int id;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<Season> seasons;
  String overview;
  String? posterPath;
  String? originalName;
  double voteAverage;

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
