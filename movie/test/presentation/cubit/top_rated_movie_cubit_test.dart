import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/get_top_rated_movies.dart';
import 'package:movie/presentation/cubit/top_rated_movie/top_rated_movie_cubit.dart';
import 'package:movie/presentation/cubit/top_rated_movie/top_rated_movie_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieCubit topRatedMovieCubit;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieCubit = TopRatedMovieCubit(mockGetTopRatedMovies);
  });

  test('initial state should be initial state', () {
    expect(topRatedMovieCubit.state, TopRatedMovieInitialState());
  });

  blocTest<TopRatedMovieCubit, TopRatedMovieState>(
    'Should emit [Loading, Error] when get top rated movie is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedMovieCubit;
    },
    act: (cubit) => cubit.fetchTopRatedMovies(),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMovieCubit, TopRatedMovieState>(
    'Should emit [Loading, Loaded] when top rated movie is successful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedMovieCubit;
    },
    act: (cubit) => cubit.fetchTopRatedMovies(),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
