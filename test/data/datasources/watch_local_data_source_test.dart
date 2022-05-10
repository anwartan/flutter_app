import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/watch_local_data_source.dart';
import 'package:ditonton/common/enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = WatchLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testWatchTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testWatchTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testWatchTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testWatchTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testWatchTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testWatchTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testWatchTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testWatchTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Watch By refId and type', () {
    final tId = 1;

    test('should return Watch Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchByRefIdAndType(tId,Type.MOVIE))
          .thenAnswer((_) async => testWatchMap);
      // act
      final result = await dataSource.getWatchByIdAndType(tId,Type.MOVIE);
      // assert
      expect(result, testWatchTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchByRefIdAndType(tId,Type.MOVIE)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getWatchByIdAndType(tId,Type.MOVIE);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlist())
          .thenAnswer((_) async => [testWatchMap]);
      // act
      final result = await dataSource.getWatchlist();
      // assert
      expect(result, [testWatchTable]);
    });
  });
}
