import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    repository = TvRepositoryImpl(tvRemoteDataSource: mockTvRemoteDataSource);
  });

  group("get now playing on tv", () {
    test('should return list of tv when call to data is successfull', () async {
      when(mockTvRemoteDataSource.getNowPlayingOnTv())
          .thenAnswer((_) async => [testTvModel]);
      // act
      final result = await repository.getNowPlayingOnTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testTv]);
    });
    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingOnTv())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingOnTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingOnTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingOnTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
    test(
        'should return SLLFailure when ssl is invalid',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getNowPlayingOnTv())
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getNowPlayingOnTv();
          // assert
          expect(
              result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
        });
  });

  group("get popular on tv", () {
    test('should return list of tv when call to data source is successfull',
        () async {
      when(mockTvRemoteDataSource.getPopularOnTv())
          .thenAnswer((_) async => [testTvModel]);
      // act
      final result = await repository.getPopularOnTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testTv]);
    });
    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularOnTv())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularOnTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularOnTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularOnTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test(
        'should return SSLFailure when ssl is invalid',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getPopularOnTv())
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getPopularOnTv();
          // assert
          expect(
              result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
        });
  });

  group("search on tv", () {
    const query = "spiderman";
    test("should return list of tv when call to data source is successfull",
        () async {
      when(mockTvRemoteDataSource.searchTv(query))
          .thenAnswer((_) async => [testTvModel]);
      // act
      final result = await repository.searchOnTv(query);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testTv]);
    });
    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(query)).thenThrow(ServerException());
      // act
      final result = await repository.searchOnTv(query);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(query))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchOnTv(query);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test(
        'should return SSLFailure when ssl is invalid',
            () async {
          // arrange
          when(mockTvRemoteDataSource.searchTv(query))
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.searchOnTv(query);
          // assert
          expect(
              result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
        });
  });

  group("get detail on tv", () {
    const tId = 1;
    test(
        'should return tv data when the call to remote data source is successful',
        () async {
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => testTvDetailModel);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return ssl failure when ssl is invalid',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvDetail(tId))
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockTvRemoteDataSource.getTvDetail(tId));
          expect(result,
              equals(Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'))));
        });
  });

  group("get recommendations on tv", () {
    const tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => [testTvModel]);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals([testTv]));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return ssl failure when ssl is invalid',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvRecommendations(tId))
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getTvRecommendations(tId);
          // assert
          verify(mockTvRemoteDataSource.getTvRecommendations(tId));
          expect(result,
              equals(Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'))));
        });
  });
  group('get episodes by season', () {
    const tId = 1;
    const tIdSeason = 1;
    test('should return list of watch', () async {
      // arrange
      when(mockTvRemoteDataSource.getTvEpisodeBySeason(tId, tIdSeason))
          .thenAnswer((_) async => [testEpisodeModel]);
      // act
      final result = await repository.getTvEpisodeBySeason(tId, tIdSeason);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testEpisode]);
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvEpisodeBySeason(tId, tIdSeason))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvEpisodeBySeason(tId, tIdSeason);
      // assert
      verify(mockTvRemoteDataSource.getTvEpisodeBySeason(tId, tIdSeason));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvEpisodeBySeason(tId, tIdSeason))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvEpisodeBySeason(tId, tIdSeason);
      // assert
      verify(mockTvRemoteDataSource.getTvEpisodeBySeason(tId, tIdSeason));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return SSLfailure when ssl is invalid',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvEpisodeBySeason(tId, tIdSeason))
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getTvEpisodeBySeason(tId, tIdSeason);
          // assert
          verify(mockTvRemoteDataSource.getTvEpisodeBySeason(tId, tIdSeason));
          expect(result,
              equals(Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'))));
        });
  });

  group("get top rated on tv", () {
    test('should return list of tv when call to data is successfull', () async {
      when(mockTvRemoteDataSource.getTvTopRated())
          .thenAnswer((_) async => [testTvModel]);
      // act
      final result = await repository.getTopRatedOnTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testTv]);
    });
    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvTopRated())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedOnTv();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvTopRated())
              .thenThrow(const SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedOnTv();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });

    test(
        'should return SSLFailure when ssl is invalid',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvTopRated())
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getTopRatedOnTv();
          // assert
          expect(
              result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
        });
  });

}
