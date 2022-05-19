// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;
import 'dart:convert' as _i32;
import 'dart:io' as _i5;
import 'dart:typed_data' as _i33;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/enum.dart' as _i16;
import 'package:ditonton/common/failure.dart' as _i10;
import 'package:ditonton/common/ssl_pinning.dart' as _i30;
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i27;
import 'package:ditonton/data/datasources/movie_remote_data_source.dart'
    as _i20;
import 'package:ditonton/data/datasources/tv_remote_data_source.dart' as _i22;
import 'package:ditonton/data/datasources/watch_local_data_source.dart' as _i25;
import 'package:ditonton/data/models/episode_model.dart' as _i24;
import 'package:ditonton/data/models/movie_detail_model.dart' as _i3;
import 'package:ditonton/data/models/movie_model.dart' as _i21;
import 'package:ditonton/data/models/tv_detail_model.dart' as _i4;
import 'package:ditonton/data/models/tv_model.dart' as _i23;
import 'package:ditonton/data/models/watch_table.dart' as _i26;
import 'package:ditonton/domain/entities/episode.dart' as _i13;
import 'package:ditonton/domain/entities/movie.dart' as _i18;
import 'package:ditonton/domain/entities/movie_detail.dart' as _i19;
import 'package:ditonton/domain/entities/tv.dart' as _i11;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i12;
import 'package:ditonton/domain/entities/watch.dart' as _i15;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i17;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i8;
import 'package:ditonton/domain/repositories/watch_repository.dart' as _i14;
import 'package:flutter/src/widgets/navigator.dart' as _i29;
import 'package:http/io_client.dart' as _i7;
import 'package:http/src/base_request.dart' as _i31;
import 'package:http/src/response.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i28;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieDetailResponse_1 extends _i1.Fake
    implements _i3.MovieDetailResponse {}

class _FakeTvDetailModel_2 extends _i1.Fake implements _i4.TvDetailModel {}

class _FakeSecurityContext_3 extends _i1.Fake implements _i5.SecurityContext {}

class _FakeResponse_4 extends _i1.Fake implements _i6.Response {}

class _FakeIOStreamedResponse_5 extends _i1.Fake
    implements _i7.IOStreamedResponse {}

/// A class which mocks [TvRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRepository extends _i1.Mock implements _i8.TvRepository {
  MockTvRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Tv>>> getNowPlayingOnTv() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingOnTv, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Tv>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Tv>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Tv>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Tv>>> getPopularOnTv() =>
      (super.noSuchMethod(Invocation.method(#getPopularOnTv, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Tv>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Tv>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Tv>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Tv>>> searchOnTv(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchOnTv, [query]),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Tv>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Tv>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Tv>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, _i12.TvDetail>> getTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvDetail, [id]),
          returnValue: Future<_i2.Either<_i10.Failure, _i12.TvDetail>>.value(
              _FakeEither_0<_i10.Failure, _i12.TvDetail>())) as _i9
          .Future<_i2.Either<_i10.Failure, _i12.TvDetail>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Tv>>> getTvRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Tv>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Tv>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Tv>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i13.Episode>>> getTvEpisodeBySeason(
          int? idTv, int? idSeason) =>
      (super.noSuchMethod(
              Invocation.method(#getTvEpisodeBySeason, [idTv, idSeason]),
              returnValue:
                  Future<_i2.Either<_i10.Failure, List<_i13.Episode>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i13.Episode>>()))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i13.Episode>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Tv>>> getTopRatedOnTv() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedOnTv, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Tv>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Tv>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Tv>>>);
}

/// A class which mocks [WatchRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchRepository extends _i1.Mock implements _i14.WatchRepository {
  MockWatchRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> saveWatchlist(
          _i15.Watch? watch) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [watch]),
              returnValue: Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>()))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> removeWatchlist(
          _i15.Watch? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>()))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<bool> isAddedToWatchlist(int? refId, _i16.Type? type) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [refId, type]),
          returnValue: Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i15.Watch>>> getWatchlist() =>
      (super.noSuchMethod(Invocation.method(#getWatchlist, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i15.Watch>>>.value(
              _FakeEither_0<_i10.Failure, List<_i15.Watch>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i15.Watch>>>);
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i17.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>
      getNowPlayingMovies() => (super.noSuchMethod(
          Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i18.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i18.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i18.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, _i19.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i10.Failure, _i19.MovieDetail>>.value(
              _FakeEither_0<_i10.Failure, _i19.MovieDetail>())) as _i9
          .Future<_i2.Either<_i10.Failure, _i19.MovieDetail>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>
      getMovieRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i18.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i18.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i18.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i20.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<List<_i21.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i21.MovieModel>>.value(<_i21.MovieModel>[]))
          as _i9.Future<List<_i21.MovieModel>>);
  @override
  _i9.Future<List<_i21.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i21.MovieModel>>.value(<_i21.MovieModel>[]))
      as _i9.Future<List<_i21.MovieModel>>);
  @override
  _i9.Future<List<_i21.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i21.MovieModel>>.value(<_i21.MovieModel>[]))
      as _i9.Future<List<_i21.MovieModel>>);
  @override
  _i9.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as _i9.Future<_i3.MovieDetailResponse>);
  @override
  _i9.Future<List<_i21.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i21.MovieModel>>.value(<_i21.MovieModel>[]))
          as _i9.Future<List<_i21.MovieModel>>);
  @override
  _i9.Future<List<_i21.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i21.MovieModel>>.value(<_i21.MovieModel>[]))
          as _i9.Future<List<_i21.MovieModel>>);
}

/// A class which mocks [TvRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRemoteDataSource extends _i1.Mock
    implements _i22.TvRemoteDataSource {
  MockTvRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<List<_i23.TvModel>> getNowPlayingOnTv() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingOnTv, []),
              returnValue: Future<List<_i23.TvModel>>.value(<_i23.TvModel>[]))
          as _i9.Future<List<_i23.TvModel>>);
  @override
  _i9.Future<List<_i23.TvModel>> getPopularOnTv() =>
      (super.noSuchMethod(Invocation.method(#getPopularOnTv, []),
              returnValue: Future<List<_i23.TvModel>>.value(<_i23.TvModel>[]))
          as _i9.Future<List<_i23.TvModel>>);
  @override
  _i9.Future<_i4.TvDetailModel> getTvDetail(int? id) => (super.noSuchMethod(
          Invocation.method(#getTvDetail, [id]),
          returnValue: Future<_i4.TvDetailModel>.value(_FakeTvDetailModel_2()))
      as _i9.Future<_i4.TvDetailModel>);
  @override
  _i9.Future<List<_i23.TvModel>> getTvRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
              returnValue: Future<List<_i23.TvModel>>.value(<_i23.TvModel>[]))
          as _i9.Future<List<_i23.TvModel>>);
  @override
  _i9.Future<List<_i24.EpisodeModel>> getTvEpisodeBySeason(
          int? idTv, int? idSeason) =>
      (super.noSuchMethod(
              Invocation.method(#getTvEpisodeBySeason, [idTv, idSeason]),
              returnValue:
                  Future<List<_i24.EpisodeModel>>.value(<_i24.EpisodeModel>[]))
          as _i9.Future<List<_i24.EpisodeModel>>);
  @override
  _i9.Future<List<_i23.TvModel>> searchTv(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTv, [query]),
              returnValue: Future<List<_i23.TvModel>>.value(<_i23.TvModel>[]))
          as _i9.Future<List<_i23.TvModel>>);
  @override
  _i9.Future<List<_i23.TvModel>> getTvTopRated() =>
      (super.noSuchMethod(Invocation.method(#getTvTopRated, []),
              returnValue: Future<List<_i23.TvModel>>.value(<_i23.TvModel>[]))
          as _i9.Future<List<_i23.TvModel>>);
}

/// A class which mocks [WatchLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchLocalDataSource extends _i1.Mock
    implements _i25.WatchLocalDataSource {
  MockWatchLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<String> insertWatchlist(_i26.WatchTable? watch) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [watch]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<String> removeWatchlist(_i26.WatchTable? watch) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [watch]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<_i26.WatchTable?> getWatchByIdAndType(
          int? refId, _i16.Type? type) =>
      (super.noSuchMethod(
              Invocation.method(#getWatchByIdAndType, [refId, type]),
              returnValue: Future<_i26.WatchTable?>.value())
          as _i9.Future<_i26.WatchTable?>);
  @override
  _i9.Future<List<_i26.WatchTable>> getWatchlist() => (super.noSuchMethod(
          Invocation.method(#getWatchlist, []),
          returnValue: Future<List<_i26.WatchTable>>.value(<_i26.WatchTable>[]))
      as _i9.Future<List<_i26.WatchTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i27.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i28.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i28.Database?>.value())
          as _i9.Future<_i28.Database?>);
  @override
  _i9.Future<int> insertWatchlist(_i26.WatchTable? watch) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [watch]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<int> removeWatchlist(_i26.WatchTable? watch) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [watch]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<List<Map<String, dynamic>>> getWatchlist() => (super.noSuchMethod(
      Invocation.method(#getWatchlist, []),
      returnValue: Future<List<Map<String, dynamic>>>.value(
          <Map<String, dynamic>>[])) as _i9.Future<List<Map<String, dynamic>>>);
  @override
  _i9.Future<Map<String, dynamic>?> getWatchByRefIdAndType(
          int? refId, _i16.Type? type) =>
      (super.noSuchMethod(
              Invocation.method(#getWatchByRefIdAndType, [refId, type]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i9.Future<Map<String, dynamic>?>);
}

/// A class which mocks [NavigatorObserver].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigatorObserver extends _i1.Mock implements _i29.NavigatorObserver {
  MockNavigatorObserver() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void didPush(
          _i29.Route<dynamic>? route, _i29.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didPush, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didPop(_i29.Route<dynamic>? route, _i29.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didPop, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didRemove(
          _i29.Route<dynamic>? route, _i29.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didRemove, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didReplace(
          {_i29.Route<dynamic>? newRoute, _i29.Route<dynamic>? oldRoute}) =>
      super.noSuchMethod(
          Invocation.method(
              #didReplace, [], {#newRoute: newRoute, #oldRoute: oldRoute}),
          returnValueForMissingStub: null);
  @override
  void didStartUserGesture(
          _i29.Route<dynamic>? route, _i29.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(
          Invocation.method(#didStartUserGesture, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didStopUserGesture() =>
      super.noSuchMethod(Invocation.method(#didStopUserGesture, []),
          returnValueForMissingStub: null);
}

/// A class which mocks [CustomIOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i30.CustomIOClient {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i5.SecurityContext> get globalContext =>
      (super.noSuchMethod(Invocation.getter(#globalContext),
              returnValue:
                  Future<_i5.SecurityContext>.value(_FakeSecurityContext_3()))
          as _i9.Future<_i5.SecurityContext>);
  @override
  _i9.Future<_i6.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i7.IOStreamedResponse> send(_i31.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: Future<_i7.IOStreamedResponse>.value(
                  _FakeIOStreamedResponse_5()))
          as _i9.Future<_i7.IOStreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  _i9.Future<_i6.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i32.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i32.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i32.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i32.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i6.Response>.value(_FakeResponse_4()))
          as _i9.Future<_i6.Response>);
  @override
  _i9.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<_i33.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i33.Uint8List>.value(_i33.Uint8List(0)))
          as _i9.Future<_i33.Uint8List>);
}
