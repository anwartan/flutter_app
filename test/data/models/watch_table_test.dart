import 'package:ditonton/data/models/watch_table.dart';
import 'package:ditonton/domain/entities/watch.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tWatchModel = WatchTable(refId: 1, title: "title", posterPath: "posterPath", overview: "overview", type: Type.MOVIE,id: 1);

  final tWatch = Watch(refId: 1, title: "title", posterPath: "posterPath", overview: "overview", type:  Type.MOVIE,id: 1);

  final tWatchModelWithoutId = WatchTable(refId: 1, title: "title", posterPath: "posterPath", overview: "overview", type: Type.MOVIE);

  final tWatchWithoutId = Watch(refId: 1, title: "title", posterPath: "posterPath", overview: "overview", type:  Type.MOVIE);


  group('toEntity',(){
    test('should be a subclass of Season entity', () async {
      final result = tWatchModel.toEntity();
      expect(result, tWatch);
    });
    test('should be a subclass of Season entity without id', () async {
      final result = tWatchModelWithoutId.toEntity();
      expect(result, tWatchWithoutId);
    });
  });


  group('fromMap', () {
    test('should return a valid model from Map', () async {
      // arrange
      final Map<String, dynamic> jsonMap =testWatchMap;
      // act
      final result = WatchTable.fromMap(jsonMap);
      // assert
      expect(result, tWatchModel);
    });

  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = testWatchMap;
      // act
      final result = tWatchModel.toJson();
      // assert
      expect(result, expectedJsonMap);

    });
    test('should return a JSON map containing proper data without id', () async {
      // arrange
      final expectedJsonMap = testWatchMapWithoutId;
      // act
      final result = tWatchModelWithoutId.toJson();
      // assert
      expect(result, expectedJsonMap);

    });
  });
  group('fromEntity', () {
    test('should return a Watch Table', () async {
      // arrange
      final expectedJsonMap = tWatchModelWithoutId;
      // act
      final result = WatchTable.fromEntity(tWatch);
      // assert
      expect(result, expectedJsonMap);

    });
  });
}
