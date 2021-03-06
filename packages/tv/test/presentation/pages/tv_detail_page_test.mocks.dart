// Mocks generated by Mockito 5.2.0 from annotations
// in tv/test/presentation/pages/tv_detail_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i14;

import 'package:core/core.dart' as _i19;
import 'package:core/domain/entities/movie_detail.dart' as _i17;
import 'package:core/domain/entities/tv_detail.dart' as _i18;
import 'package:flutter_bloc/flutter_bloc.dart' as _i15;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/usecases/get_episode_tv.dart' as _i11;
import 'package:tv/domain/usecases/get_tv_detail.dart' as _i2;
import 'package:tv/domain/usecases/get_tv_recommendation.dart' as _i9;
import 'package:tv/presentation/cubit/tv_detail/tv_detail_cubit.dart' as _i13;
import 'package:tv/presentation/cubit/tv_detail/tv_detail_state.dart' as _i3;
import 'package:tv/presentation/cubit/tv_recommendation/tv_recommendation_cubit.dart'
    as _i20;
import 'package:tv/presentation/cubit/tv_recommendation/tv_recommendation_state.dart'
    as _i10;
import 'package:tv/presentation/cubit/tv_season/tv_season_cubit.dart' as _i21;
import 'package:tv/presentation/cubit/tv_season/tv_season_state.dart' as _i12;
import 'package:watch/domain/get_watchlist.dart' as _i4;
import 'package:watch/domain/get_watchlist_status.dart' as _i6;
import 'package:watch/domain/remove_watchlist.dart' as _i7;
import 'package:watch/domain/save_watchlist.dart' as _i5;
import 'package:watch/presentation/cubic/watch/watch_cubit.dart' as _i16;
import 'package:watch/presentation/cubic/watch/watch_state.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetTvDetail_0 extends _i1.Fake implements _i2.GetTvDetail {}

class _FakeTvDetailState_1 extends _i1.Fake implements _i3.TvDetailState {}

class _FakeGetWatchlist_2 extends _i1.Fake implements _i4.GetWatchlist {}

class _FakeSaveWatchlist_3 extends _i1.Fake implements _i5.SaveWatchlist {}

class _FakeGetWatchListStatus_4 extends _i1.Fake
    implements _i6.GetWatchListStatus {}

class _FakeRemoveWatchlist_5 extends _i1.Fake implements _i7.RemoveWatchlist {}

class _FakeWatchState_6 extends _i1.Fake implements _i8.WatchState {}

class _FakeGetTvRecommendations_7 extends _i1.Fake
    implements _i9.GetTvRecommendations {}

class _FakeTvRecommendationState_8 extends _i1.Fake
    implements _i10.TvRecommendationState {}

class _FakeGetEpisodeTv_9 extends _i1.Fake implements _i11.GetEpisodeTv {}

class _FakeTvSeasonState_10 extends _i1.Fake implements _i12.TvSeasonState {}

/// A class which mocks [TvDetailCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailCubit extends _i1.Mock implements _i13.TvDetailCubit {
  MockTvDetailCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvDetail get getTvDetail =>
      (super.noSuchMethod(Invocation.getter(#getTvDetail),
          returnValue: _FakeGetTvDetail_0()) as _i2.GetTvDetail);
  @override
  _i3.TvDetailState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeTvDetailState_1()) as _i3.TvDetailState);
  @override
  _i14.Stream<_i3.TvDetailState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.TvDetailState>.empty())
          as _i14.Stream<_i3.TvDetailState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i14.Future<void> fetchTvSeriesDetail(int? id) => (super.noSuchMethod(
      Invocation.method(#fetchTvSeriesDetail, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i14.Future<void>);
  @override
  void emit(_i3.TvDetailState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i15.Change<_i3.TvDetailState>? change) =>
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
  _i14.Future<void> close() => (super.noSuchMethod(
      Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i14.Future<void>);
}

/// A class which mocks [WatchCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchCubit extends _i1.Mock implements _i16.WatchCubit {
  MockWatchCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.GetWatchlist get getWatchlist =>
      (super.noSuchMethod(Invocation.getter(#getWatchlist),
          returnValue: _FakeGetWatchlist_2()) as _i4.GetWatchlist);
  @override
  _i5.SaveWatchlist get saveWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlist),
          returnValue: _FakeSaveWatchlist_3()) as _i5.SaveWatchlist);
  @override
  _i6.GetWatchListStatus get getWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatus),
          returnValue: _FakeGetWatchListStatus_4()) as _i6.GetWatchListStatus);
  @override
  _i7.RemoveWatchlist get removeWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlist),
          returnValue: _FakeRemoveWatchlist_5()) as _i7.RemoveWatchlist);
  @override
  _i8.WatchState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeWatchState_6()) as _i8.WatchState);
  @override
  _i14.Stream<_i8.WatchState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i8.WatchState>.empty())
          as _i14.Stream<_i8.WatchState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i14.Future<void> fetchWatchlist() => (super.noSuchMethod(
      Invocation.method(#fetchWatchlist, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i14.Future<void>);
  @override
  _i14.Future<void> addWatchlistMovie(_i17.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#addWatchlistMovie, [movie]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i14.Future<void>);
  @override
  _i14.Future<void> addWatchlistTv(_i18.TvDetail? tvDetail) =>
      (super.noSuchMethod(Invocation.method(#addWatchlistTv, [tvDetail]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i14.Future<void>);
  @override
  _i14.Future<void> removeWatchlistMovie(_i17.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistMovie, [movie]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i14.Future<void>);
  @override
  _i14.Future<void> removeWatchlistTv(_i18.TvDetail? tvDetail) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTv, [tvDetail]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i14.Future<void>);
  @override
  _i14.Future<void> isAddedToWatchlist(int? id, _i19.Type? type) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id, type]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i14.Future<void>);
  @override
  void emit(_i8.WatchState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i15.Change<_i8.WatchState>? change) =>
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
  _i14.Future<void> close() => (super.noSuchMethod(
      Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i14.Future<void>);
}

/// A class which mocks [TvRecommendationCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRecommendationCubit extends _i1.Mock
    implements _i20.TvRecommendationCubit {
  MockTvRecommendationCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.GetTvRecommendations get getTvRecommendations => (super.noSuchMethod(
      Invocation.getter(#getTvRecommendations),
      returnValue: _FakeGetTvRecommendations_7()) as _i9.GetTvRecommendations);
  @override
  _i10.TvRecommendationState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
              returnValue: _FakeTvRecommendationState_8())
          as _i10.TvRecommendationState);
  @override
  _i14.Stream<_i10.TvRecommendationState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i10.TvRecommendationState>.empty())
          as _i14.Stream<_i10.TvRecommendationState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i14.Future<void> fetchTvRecommendation(int? id) => (super.noSuchMethod(
      Invocation.method(#fetchTvRecommendation, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i14.Future<void>);
  @override
  void emit(_i10.TvRecommendationState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i15.Change<_i10.TvRecommendationState>? change) =>
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
  _i14.Future<void> close() => (super.noSuchMethod(
      Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i14.Future<void>);
}

/// A class which mocks [TvSeasonCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeasonCubit extends _i1.Mock implements _i21.TvSeasonCubit {
  MockTvSeasonCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.GetEpisodeTv get getEpisodeTv =>
      (super.noSuchMethod(Invocation.getter(#getEpisodeTv),
          returnValue: _FakeGetEpisodeTv_9()) as _i11.GetEpisodeTv);
  @override
  _i12.TvSeasonState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeTvSeasonState_10()) as _i12.TvSeasonState);
  @override
  _i14.Stream<_i12.TvSeasonState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i12.TvSeasonState>.empty())
          as _i14.Stream<_i12.TvSeasonState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i14.Future<void> fetchTvEpisodeBySeason(
          int? idTv, int? idSeason, int? seasonNumber) =>
      (super.noSuchMethod(
              Invocation.method(
                  #fetchTvEpisodeBySeason, [idTv, idSeason, seasonNumber]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i14.Future<void>);
  @override
  void emit(_i12.TvSeasonState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i15.Change<_i12.TvSeasonState>? change) =>
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
  _i14.Future<void> close() => (super.noSuchMethod(
      Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i14.Future<void>);
}
