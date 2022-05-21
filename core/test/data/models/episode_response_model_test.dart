
import 'dart:convert';

import 'package:core/data/models/episode_model.dart';
import 'package:core/data/models/episode_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main(){
  final date = DateTime.parse("2011-04-17");
  final tEpisodeModel = EpisodeModel(
      airDate: date,
      episodeNumber: 1,
      id: 63056,
      name: "Winter Is Coming",
      overview: "Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.",
      productionCode: "101",
      seasonNumber: 1,
      stillPath: "/xIfvIM7YgkADTrqp23rm3CLaOVQ.jpg",
      voteAverage: 7.7,
      voteCount: 179);
  final EpisodeResponse episodeResponse = EpisodeResponse(episodes: <EpisodeModel>[tEpisodeModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/tv_episodes.json'));
      // act
      final result = EpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, episodeResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = episodeResponse.toJson();
      // assert
      final expectedJsonMap = {
        "episodes": [
          {
            "air_date": "2011-04-17",
            "episode_number": 1,
            "id": 63056,
            "name": "Winter Is Coming",
            "overview": "Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon's place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.",
            "production_code": "101",
            "season_number": 1,
            "still_path": "/xIfvIM7YgkADTrqp23rm3CLaOVQ.jpg",
            "vote_average": 7.7,
            "vote_count": 179
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}