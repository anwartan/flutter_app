import 'package:core/data/models/episode_model.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final date = DateTime.parse("2010-05-05");
  final tEpisodeModel = EpisodeModel(
      airDate: date,
      episodeNumber: 1,
      id: 1,
      name: "name",
      overview: "overview",
      productionCode: "productionCode",
      seasonNumber: 1,
      stillPath: "stillPath",
      voteAverage: 1,
      voteCount: 2);

  final tEpisode = Episode(airDate: date, episodeNumber: 1, id: 1, name: "name", overview: "overview", productionCode: "productionCode", seasonNumber: 1, stillPath: "stillPath", voteAverage: 1, voteCount: 2);

  test('should be a subclass of Episode entity', () async {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });

}
