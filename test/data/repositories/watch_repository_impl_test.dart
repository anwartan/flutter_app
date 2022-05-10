import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/watch_repository_impl.dart';
import 'package:ditonton/common/enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){

  late WatchRepositoryImpl repository;
  late MockWatchLocalDataSource mockWatchLocalDataSource;

  setUp((){
    mockWatchLocalDataSource = MockWatchLocalDataSource();
    repository = WatchRepositoryImpl(localDataSource: mockWatchLocalDataSource);
  });
  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange

      when(mockWatchLocalDataSource.insertWatchlist(testWatchTableWithoutId))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testWatch);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {

      // arrange
      when(mockWatchLocalDataSource.insertWatchlist(testWatchTableWithoutId))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testWatch);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {

      // arrange
      when(mockWatchLocalDataSource.removeWatchlist(testWatchTableWithoutId))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testWatch);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockWatchLocalDataSource.removeWatchlist(testWatchTableWithoutId))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testWatch);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      final type = Type.MOVIE;
      when(mockWatchLocalDataSource.getWatchByIdAndType(tId,type)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId,type);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of watch', () async {
      // arrange
      when(mockWatchLocalDataSource.getWatchlist())
          .thenAnswer((_) async => [testWatchTable]);
      // act
      final result = await repository.getWatchlist();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatch]);
    });
  });
}