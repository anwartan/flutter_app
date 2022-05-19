
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_on_tv.dart';
import 'package:ditonton/presentation/cubit/on_air_tv/on_air_tv_cubit.dart';
import 'package:ditonton/presentation/cubit/on_air_tv/on_air_tv_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_air_tv_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingOnTv])
void main() {
  late OnAirTvCubit onAirTvCubit;
  late MockGetNowPlayingOnTv mockGetNowPlayingOnTv;
  setUp(() {
    mockGetNowPlayingOnTv = MockGetNowPlayingOnTv();
    onAirTvCubit = OnAirTvCubit(mockGetNowPlayingOnTv);
  });

  test('initial state should be initial state', () {
    expect(onAirTvCubit.state, OnAirTvInitialState());
  });

  blocTest<OnAirTvCubit, OnAirTvState>(
    'Should emit [Loading, Error] when get on air tv is unsuccessful',
    build: () {
      when(mockGetNowPlayingOnTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return onAirTvCubit;
    },
    act: (cubit) => cubit.fetchOnAirOnTv() ,
    expect: () => [
      OnAirTvLoading(),
      OnAirTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingOnTv.execute());
    },
  );

  blocTest<OnAirTvCubit, OnAirTvState>(
    'Should emit [Loading, Loaded] when get on air tv is successful',
    build: () {
      when(mockGetNowPlayingOnTv.execute())
          .thenAnswer((_) async => Right(testTvs));
      return onAirTvCubit;
    },
    act: (cubit) => cubit.fetchOnAirOnTv() ,
    expect: () => [
      OnAirTvLoading(),
      OnAirTvLoaded(testTvs),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingOnTv.execute());
    },
  );

}