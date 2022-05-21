// Mocks generated by Mockito 5.2.0 from annotations
// in movie/test/presentation/pages/popular_movies_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:flutter_bloc/flutter_bloc.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/get_popular_movies.dart' as _i2;
import 'package:movie/presentation/cubit/popular_movie/popular_movie_cubit.dart'
    as _i4;
import 'package:movie/presentation/cubit/popular_movie/popular_movie_state.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetPopularMovies_0 extends _i1.Fake implements _i2.GetPopularMovies {
}

class _FakePopularMovieState_1 extends _i1.Fake
    implements _i3.PopularMovieState {}

/// A class which mocks [PopularMovieCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularMovieCubit extends _i1.Mock implements _i4.PopularMovieCubit {
  MockPopularMovieCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetPopularMovies get getPopularMovies =>
      (super.noSuchMethod(Invocation.getter(#getPopularMovies),
          returnValue: _FakeGetPopularMovies_0()) as _i2.GetPopularMovies);
  @override
  _i3.PopularMovieState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakePopularMovieState_1()) as _i3.PopularMovieState);
  @override
  _i5.Stream<_i3.PopularMovieState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.PopularMovieState>.empty())
          as _i5.Stream<_i3.PopularMovieState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i5.Future<void> fetchPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#fetchPopularMovies, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  void emit(_i3.PopularMovieState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i6.Change<_i3.PopularMovieState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
}
