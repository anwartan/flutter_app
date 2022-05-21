
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watch/domain/get_watchlist.dart';
import 'package:watch/domain/get_watchlist_status.dart';
import 'package:watch/domain/remove_watchlist.dart';
import 'package:watch/domain/save_watchlist.dart';
import 'package:watch/presentation/cubic/watch/watch_cubit.dart';
import 'package:watch/presentation/cubic/watch/watch_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watch_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
  GetWatchlist
])
void main() {
  late WatchCubit watchCubit;
  late MockGetWatchlist mockGetWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  setUp(() {
    mockGetWatchlist = MockGetWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchCubit = WatchCubit(mockGetWatchlist, mockSaveWatchlist, mockGetWatchListStatus, mockRemoveWatchlist);

  });
  test('initial state should be initial state', () {
    expect(watchCubit.state, WatchInitialState());
  });

  const int id = 1;

  blocTest<WatchCubit, WatchState>(
    'Should emit [Loading, Error] when get watch list is unsuccessful',
    build: () {
      when(mockGetWatchlist.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchCubit;
    },
    act: (cubit) => cubit.fetchWatchlist(),
    expect: () => [
      WatchLoading(),
      WatchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlist.execute());
    },
  );

  blocTest<WatchCubit, WatchState>(
    'Should emit [Loading, Loaded] when get watch list is successful',
    build: () {
      when(mockGetWatchlist.execute())
          .thenAnswer((_) async => Right(testWatchList));
      return watchCubit;
    },
    act: (cubit) => cubit.fetchWatchlist(),
    expect: () => [
      WatchLoading(),
      WatchListLoaded(testWatchList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlist.execute());
    },
  );
  blocTest<WatchCubit, WatchState>(
    'Should emit [ Loaded] when isAddedToWatchlist type Movie is successful',
    build: () {
      when(mockGetWatchListStatus.execute(id,Type.MOVIE))
          .thenAnswer((_) async => true);
      return watchCubit;
    },
    act: (cubit) => cubit.isAddedToWatchlist(id, Type.MOVIE),
    expect: () => [
      WatchCheckAdded(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(id,Type.MOVIE));
    },
  );
  blocTest<WatchCubit, WatchState>(
    'Should emit [ Loaded] when isAddedToWatchlist type Tv is successful',
    build: () {
      when(mockGetWatchListStatus.execute(id,Type.TV))
          .thenAnswer((_) async => true);
      return watchCubit;
    },
    act: (cubit) => cubit.isAddedToWatchlist(id,Type.TV),
    expect: () => [
      WatchCheckAdded(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(id,Type.TV));
    },
  );

  blocTest<WatchCubit, WatchState>(
    'Should emit [ Loaded] when addWatchlistMovie  is successful',
    build: () {
      when(mockSaveWatchlist.execute(testWatch))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return watchCubit;
    },
    act: (cubit) => cubit.addWatchlistMovie(testMovieDetail),
    expect: () => [
      WatchMessage('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testWatch));
    },
  );

  blocTest<WatchCubit, WatchState>(
    'Should emit [ Error] when addWatchlistMovie  is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testWatch))
          .thenAnswer((_) async =>  Left(DatabaseFailure("Can't get data")));
      return watchCubit;
    },
    act: (cubit) => cubit.addWatchlistMovie(testMovieDetail),
    expect: () => [

      WatchError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testWatch));
    },
  );

  blocTest<WatchCubit, WatchState>(
    'Should emit [ Error] when addWatchlistTv  is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail.copyToWatch()))
          .thenAnswer((_) async =>  Left(DatabaseFailure("Can't get data")));
      return watchCubit;
    },
    act: (cubit) => cubit.addWatchlistTv(testTvDetail),
    expect: () => [
      WatchError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail.copyToWatch()));
    },
  );

  blocTest<WatchCubit, WatchState>(
    'Should emit [ Loaded] when addWatchlistTv  is successful',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail.copyToWatch()))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return watchCubit;
    },
    act: (cubit) => cubit.addWatchlistTv(testTvDetail),
    expect: () => [
      WatchMessage('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvDetail.copyToWatch()));
    },
  );

  blocTest<WatchCubit, WatchState>(
    'Should emit [ Loaded] when removeWatchlistTv is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail.copyToWatch()))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return watchCubit;
    },
    act: (cubit) => cubit.removeWatchlistTv(testTvDetail),
    expect: () => [
      WatchMessage('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail.copyToWatch()));
    },
  );

  blocTest<WatchCubit, WatchState>(
    'Should emit [ Error] when removeWatchlistTv  is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail.copyToWatch()))
          .thenAnswer((_) async =>  Left(DatabaseFailure("Can't get data")));
      return watchCubit;
    },
    act: (cubit) => cubit.removeWatchlistTv(testTvDetail),
    expect: () => [
      WatchError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvDetail.copyToWatch()));
    },
  );
  blocTest<WatchCubit, WatchState>(
    'Should emit [ Loaded] when removeWatchlistMovie is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail.copyToWatch()))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return watchCubit;
    },
    act: (cubit) => cubit.removeWatchlistMovie(testMovieDetail),
    expect: () => [
      WatchMessage('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail.copyToWatch()));
    },
  );

  blocTest<WatchCubit, WatchState>(
    'Should emit [ Error] when removeWatchlistMovie  is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail.copyToWatch()))
          .thenAnswer((_) async =>  Left(DatabaseFailure("Can't get data")));
      return watchCubit;
    },
    act: (cubit) => cubit.removeWatchlistMovie(testMovieDetail),
    expect: () => [
      WatchError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail.copyToWatch()));
    },
  );
}