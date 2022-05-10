import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/episode_response.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';
  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing on Tv', () {
    final tvList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/tv_on_air.json')))
            .tvList;
    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_on_air.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getNowPlayingOnTv();
      // assert
      expect(result, equals(tvList));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingOnTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular on Tv', () {
    final tvList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/tv_popular.json')))
            .tvList;
    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_popular.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getPopularOnTv();
      // assert
      expect(result, equals(tvList));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularOnTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Tv Series Detail', () {
    final tTvId = 1399;
    final tvDetail = TvDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));
    test('should return list of Tv Detail Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tTvId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_detail.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTvDetail(tTvId);
      // assert
      expect(result, equals(tvDetail));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tTvId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvDetail(tTvId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Tv Recommendations ', () {
    final tTvId = 1;

    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tTvId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_recommendations.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTvRecommendations(tTvId);
      // assert
      expect(result, equals(tvList));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tTvId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendations(tTvId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search Tv by query ', () {
    final query = 'Game of Thrones';

    final tvList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/tv_search.json')))
            .tvList;
    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_search.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.searchTv(query);
      // assert
      expect(result, equals(tvList));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTv(query);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Episodes by Season Tv', () {
    final tTvId = 1399;
    final idSeason = 1;

    final tvList = EpisodeResponse.fromJson(
            json.decode(readJson('dummy_data/tv_episodes.json')))
        .episodes;

    test(
        'should return list of Episode Response Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tTvId/season/$idSeason?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_episodes.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTvEpisodeBySeason(tTvId, idSeason);
      // assert
      expect(result, equals(tvList));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tTvId/season/$idSeason?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTvEpisodeBySeason(tTvId, idSeason);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated on Tv', () {
    final tvList =
        TvResponse.fromJson(json.decode(readJson('dummy_data/tv_top_rated.json')))
            .tvList;
    test('should return list of Tv Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_top_rated.json'), 200,
              headers: {
                HttpHeaders.contentTypeHeader:
                'application/json; charset=utf-8',
              }));
          // act
          final result = await dataSource.getTvTopRated();
          // assert
          expect(result, equals(tvList));
        });
    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTvTopRated();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

}
