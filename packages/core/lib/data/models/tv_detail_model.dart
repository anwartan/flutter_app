import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailModel extends Equatable {
  const TvDetailModel(
      {required this.backdropPath,
      required this.genres,
      required this.id,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.originalName,
      required this.overview,
      required this.posterPath,
      required this.seasons,
      required this.voteAverage});

  final String? backdropPath;
  final List<GenreModel> genres;
  final int id;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final String posterPath;
  final List<SeasonModel> seasons;
  final double voteAverage;

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
      backdropPath: json["backdrop_path"],
      genres: List<GenreModel>.from(
          json["genres"].map((x) => GenreModel.fromJson(x))),
      id: json["id"],
      numberOfEpisodes: json["number_of_episodes"],
      numberOfSeasons: json["number_of_seasons"],
      originalName: json["original_name"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      seasons: List<SeasonModel>.from(
          json["seasons"].map((x) => SeasonModel.fromJson(x))),
      voteAverage: json["vote_average"].toDouble());

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "vote_average": voteAverage
      };

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        numberOfEpisodes,
        numberOfSeasons,
        originalName,
        overview,
        posterPath,
        seasons,
        voteAverage
      ];

  TvDetail toEntity() {
    return TvDetail(
        backdropPath: backdropPath,
        genres: genres.map((genre) => genre.toEntity()).toList(),
        id: id,
        originalName: originalName,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons,
        seasons: seasons.map((season) => season.toEntity()).toList(),
        overview: overview,
        posterPath: posterPath,
        voteAverage: voteAverage);
  }
}
