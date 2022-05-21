import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/get_now_playing_movies.dart';
import 'package:movie/presentation/cubit/now_playing_movie/now_playing_movie_cubit.dart';
import 'package:movie/presentation/cubit/now_playing_movie/now_playing_movie_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_movie_cubit_test.mocks.dart';


@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late NowPlayingMovieCubit nowPlayingMovieCubit;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieCubit = NowPlayingMovieCubit(mockGetNowPlayingMovies);
  });

  test('initial state should be initial state', () {
    expect(nowPlayingMovieCubit.state, NowPlayingMovieInitialState());
  });

  blocTest<NowPlayingMovieCubit, NowPlayingMovieState>(
    'Should emit [Loading, Error] when get movie detail is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingMovieCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies() ,
    expect: () => [
      NowPlayingMovieLoading(),
      NowPlayingMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMovieCubit, NowPlayingMovieState>(
    'Should emit [Loading, Loaded] when get recommendation is successful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return nowPlayingMovieCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies() ,
    expect: () => [
      NowPlayingMovieLoading(),
      NowPlayingMovieLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
