
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_episode_tv.dart';
import 'package:ditonton/presentation/cubit/tv_season/tv_season_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_season/tv_season_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_season_cubit_test.mocks.dart';

@GenerateMocks([
  GetEpisodeTv
])
void main() {
  late TvSeasonCubit tvSeasonCubit;
  late MockGetEpisodeTv mockGetEpisodeTv;
  setUp(() {
    mockGetEpisodeTv = MockGetEpisodeTv();
    tvSeasonCubit = TvSeasonCubit(mockGetEpisodeTv);
  });

  final int id = 1;
  final int idSeason = 1;
  final int seasonNumber = 1;
  test('initial state should be initial state', () {
    expect(tvSeasonCubit.state, TvSeasonInitialState());
  });

  blocTest<TvSeasonCubit, TvSeasonState>(
    'Should emit [Loading, Error] when get top rated tv is unsuccessful',
    build: () {
      when(mockGetEpisodeTv.execute(id,idSeason))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeasonCubit;
    },
    act: (cubit) => cubit.fetchTvEpisodeBySeason(id,idSeason,seasonNumber),
    expect: () => [
      TvSeasonLoading(),
      TvSeasonError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetEpisodeTv.execute(id,idSeason));
    },
  );

  blocTest<TvSeasonCubit, TvSeasonState>(
    'Should emit [Loading, Loaded] when get popular tv is successful',
    build: () {
      when(mockGetEpisodeTv.execute(id,idSeason))
          .thenAnswer((_) async => Right(testEpisodes));
      return tvSeasonCubit;
    },
    act: (cubit) => cubit.fetchTvEpisodeBySeason(id,idSeason,seasonNumber),
    expect: () => [
      TvSeasonLoading(),
      TvSeasonLoaded(idSeason,testEpisodes),
    ],
    verify: (bloc) {
      verify(mockGetEpisodeTv.execute(id,idSeason));
    },
  );

}