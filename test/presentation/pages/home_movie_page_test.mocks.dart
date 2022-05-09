// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/presentation/pages/home_movie_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i8;
import 'dart:ui' as _i9;

import 'package:ditonton/common/state_enum.dart' as _i7;
import 'package:ditonton/domain/entities/movie.dart' as _i6;
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart' as _i2;
import 'package:ditonton/domain/usecases/get_popular_movies.dart' as _i3;
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart' as _i4;
import 'package:ditonton/presentation/provider/movie_list_notifier.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetNowPlayingMovies_0 extends _i1.Fake
    implements _i2.GetNowPlayingMovies {}

class _FakeGetPopularMovies_1 extends _i1.Fake implements _i3.GetPopularMovies {
}

class _FakeGetTopRatedMovies_2 extends _i1.Fake
    implements _i4.GetTopRatedMovies {}

/// A class which mocks [MovieListNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieListNotifier extends _i1.Mock implements _i5.MovieListNotifier {
  MockMovieListNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetNowPlayingMovies get getNowPlayingMovies => (super.noSuchMethod(
      Invocation.getter(#getNowPlayingMovies),
      returnValue: _FakeGetNowPlayingMovies_0()) as _i2.GetNowPlayingMovies);
  @override
  _i3.GetPopularMovies get getPopularMovies =>
      (super.noSuchMethod(Invocation.getter(#getPopularMovies),
          returnValue: _FakeGetPopularMovies_1()) as _i3.GetPopularMovies);
  @override
  _i4.GetTopRatedMovies get getTopRatedMovies =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedMovies),
          returnValue: _FakeGetTopRatedMovies_2()) as _i4.GetTopRatedMovies);
  @override
  List<_i6.Movie> get nowPlayingMovies =>
      (super.noSuchMethod(Invocation.getter(#nowPlayingMovies),
          returnValue: <_i6.Movie>[]) as List<_i6.Movie>);
  @override
  _i7.RequestState get nowPlayingState =>
      (super.noSuchMethod(Invocation.getter(#nowPlayingState),
          returnValue: _i7.RequestState.Empty) as _i7.RequestState);
  @override
  List<_i6.Movie> get popularMovies =>
      (super.noSuchMethod(Invocation.getter(#popularMovies),
          returnValue: <_i6.Movie>[]) as List<_i6.Movie>);
  @override
  _i7.RequestState get popularMoviesState =>
      (super.noSuchMethod(Invocation.getter(#popularMoviesState),
          returnValue: _i7.RequestState.Empty) as _i7.RequestState);
  @override
  List<_i6.Movie> get topRatedMovies =>
      (super.noSuchMethod(Invocation.getter(#topRatedMovies),
          returnValue: <_i6.Movie>[]) as List<_i6.Movie>);
  @override
  _i7.RequestState get topRatedMoviesState =>
      (super.noSuchMethod(Invocation.getter(#topRatedMoviesState),
          returnValue: _i7.RequestState.Empty) as _i7.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i8.Future<void> fetchNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#fetchNowPlayingMovies, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#fetchPopularMovies, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#fetchTopRatedMovies, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  void addListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
