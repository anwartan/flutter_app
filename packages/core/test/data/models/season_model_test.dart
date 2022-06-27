import 'package:core/data/models/season_model.dart';
import 'package:core/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final DateTime date = DateTime.parse("2005-05-05");
  final tSeasonModel = SeasonModel(airDate: date, episodeCount: 1, id: 1, name: "name", overview: "overview", posterPath: "posterPath", seasonNumber: 1);


  final tSeason = Season(airDate: date, episodeCount: 1, id: 1, name: "name", overview: "overview", posterPath: "posterPath", seasonNumber: 1);

  group('toEntity',(){
    test('should be a subclass of Season entity', () async {
      final result = tSeasonModel.toEntity();
      expect(result, tSeason);
    });
  });
  group('fromJson',(){
    test('should return a valid model from JSON', () async {
      final jsonMap = {
        "air_date": "2005-05-05",
        "episode_count": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "poster_path": "posterPath",
        "season_number": 1
      };

      final result = SeasonModel.fromJson(jsonMap);
      expect(result, tSeasonModel);
    });
  });
  group('toJson',(){
    test('should return a JSON map containing proper data', () async {
      final expectedResult = {
        "air_date": "2005-05-05",
        "episode_count": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "poster_path": "posterPath",
        "season_number": 1
      };
      final result = tSeasonModel.toJson();
      expect(result, expectedResult);
    });
  });



}
