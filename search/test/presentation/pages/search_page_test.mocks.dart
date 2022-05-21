// Mocks generated by Mockito 5.2.0 from annotations
// in search/test/presentation/pages/search_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:flutter_bloc/flutter_bloc.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:search/domain/usecases/search_movies.dart' as _i2;
import 'package:search/domain/usecases/search_on_tv.dart' as _i3;
import 'package:search/presentation/cubit/search/search_cubit.dart' as _i5;
import 'package:search/presentation/cubit/search/search_state.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeSearchMovies_0 extends _i1.Fake implements _i2.SearchMovies {}

class _FakeSearchOnTv_1 extends _i1.Fake implements _i3.SearchOnTv {}

class _FakeSearchState_2 extends _i1.Fake implements _i4.SearchState {}

/// A class which mocks [SearchCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchCubit extends _i1.Mock implements _i5.SearchCubit {
  MockSearchCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SearchMovies get searchMovies =>
      (super.noSuchMethod(Invocation.getter(#searchMovies),
          returnValue: _FakeSearchMovies_0()) as _i2.SearchMovies);
  @override
  _i3.SearchOnTv get searchOnTv =>
      (super.noSuchMethod(Invocation.getter(#searchOnTv),
          returnValue: _FakeSearchOnTv_1()) as _i3.SearchOnTv);
  @override
  _i4.SearchState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeSearchState_2()) as _i4.SearchState);
  @override
  _i6.Stream<_i4.SearchState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i4.SearchState>.empty())
          as _i6.Stream<_i4.SearchState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i6.Future<void> fetchMovieSearch(String? query) =>
      (super.noSuchMethod(Invocation.method(#fetchMovieSearch, [query]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> fetchTvSearch(String? query) =>
      (super.noSuchMethod(Invocation.method(#fetchTvSearch, [query]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void emit(_i4.SearchState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i7.Change<_i4.SearchState>? change) =>
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
  _i6.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
}
