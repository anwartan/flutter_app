// Mocks generated by Mockito 5.2.0 from annotations
// in movie/test/presentation/pages/top_rated_movies_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:flutter_bloc/flutter_bloc.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/get_top_rated_movies.dart' as _i2;
import 'package:movie/presentation/cubit/top_rated_movie/top_rated_movie_cubit.dart'
    as _i4;
import 'package:movie/presentation/cubit/top_rated_movie/top_rated_movie_state.dart'
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

class _FakeGetTopRatedMovies_0 extends _i1.Fake
    implements _i2.GetTopRatedMovies {}

class _FakeTopRatedMovieState_1 extends _i1.Fake
    implements _i3.TopRatedMovieState {}

/// A class which mocks [TopRatedMovieCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedMovieCubit extends _i1.Mock
    implements _i4.TopRatedMovieCubit {
  MockTopRatedMovieCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTopRatedMovies get getTopRatedMovies =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedMovies),
          returnValue: _FakeGetTopRatedMovies_0()) as _i2.GetTopRatedMovies);
  @override
  _i3.TopRatedMovieState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeTopRatedMovieState_1()) as _i3.TopRatedMovieState);
  @override
  _i5.Stream<_i3.TopRatedMovieState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.TopRatedMovieState>.empty())
          as _i5.Stream<_i3.TopRatedMovieState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i5.Future<void> fetchTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#fetchTopRatedMovies, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  void emit(_i3.TopRatedMovieState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i6.Change<_i3.TopRatedMovieState>? change) =>
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