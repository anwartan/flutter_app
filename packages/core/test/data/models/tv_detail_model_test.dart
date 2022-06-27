import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/data/models/tv_detail_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenreModel = GenreModel(id: 1, name: "name");
  final DateTime date = DateTime.parse("2005-05-05");
  final tSeasonModel = SeasonModel(airDate: date, episodeCount: 1, id: 1, name: "name", overview: "overview", posterPath: "posterPath", seasonNumber: 1);
  final tTvDetailModel = TvDetailModel(backdropPath: "backdropPath", genres: const [tGenreModel], id: 1, numberOfEpisodes: 1, numberOfSeasons: 1, originalName: "originalName", overview: "overview", posterPath: "posterPath", seasons: [tSeasonModel], voteAverage: 1.0);
  final tGenre = Genre(id: 1, name: "name");
  final tSeason = Season(airDate: date, episodeCount: 1, id: 1, name: "name", overview: "overview", posterPath: "posterPath", seasonNumber: 1);

  final tTvDetail = TvDetail(backdropPath: "backdropPath", genres: [tGenre], id: 1, numberOfEpisodes: 1, numberOfSeasons: 1, originalName: "originalName", overview: "overview", posterPath: "posterPath", seasons: [tSeason], voteAverage: 1.0);

  final tTvDetailMap = {
    "backdrop_path": "backdropPath",
    "genres": [
      {
        "id":1,
        "name":"name"
      }
    ],
    "id": 1,
    "number_of_episodes": 1,
    "number_of_seasons": 1,
    "original_name": "originalName",
    "overview": "overview",
    "poster_path": "posterPath",
    "seasons": [
      {
        "air_date":"2005-05-05",
        "episode_count": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "poster_path": "posterPath",
        "season_number": 1,
      }
    ],
    "vote_average": 1
  };
  group('toEntity',(){
    test('should be a subclass of Tv Detail entity', () async {
      final result = tTvDetailModel.toEntity();
      expect(result, tTvDetail);
    });
  });
  group('fromJson',(){
    test('should return a valid model from JSON', () async {
      final jsonMap = tTvDetailMap;
      final result = TvDetailModel.fromJson(jsonMap);
      expect(result, tTvDetailModel);
    });
  });
  group('toJson',(){
    test('should return a JSON map containing proper data', () async {
      final expectedResult = tTvDetailMap;
      final result = tTvDetailModel.toJson();
      expect(result, expectedResult);
    });
  });
}
