import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watch/domain/get_watchlist.dart';
import 'package:watch/presentation/cubic/watch_list/watch_list_cubit.dart';
import 'package:watch/presentation/cubic/watch_list/watch_list_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watch_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchlist
])
void main() {
    late WatchListCubit watchListCubit;
    late MockGetWatchlist mockGetWatchlist;
    setUp((){
      mockGetWatchlist = MockGetWatchlist();
      watchListCubit = WatchListCubit( mockGetWatchlist);

    });

    test('initial state should be initial state', () {
      expect(watchListCubit.state, WatchListInitialState());
    });

    blocTest<WatchListCubit, WatchListState>(
      'Should emit [Loading, Error] when get watch list is unsuccessful',
      build: () {
        when(mockGetWatchlist.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchListCubit;
      },
      act: (cubit) => cubit.fetchWatchlist(),
      expect: () => [
        WatchListLoading(),
        WatchListError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlist.execute());
      },
    );

    blocTest<WatchListCubit, WatchListState>(
      'Should emit [Loading, Loaded] when get watch list is successful',
      build: () {
        when(mockGetWatchlist.execute())
            .thenAnswer((_) async => Right(testWatchList));
        return watchListCubit;
      },
      act: (cubit) => cubit.fetchWatchlist(),
      expect: () => [
        WatchListLoading(),
        WatchListLoaded(testWatchList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlist.execute());
      },
    );

}