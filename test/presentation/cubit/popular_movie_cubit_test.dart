
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/cubit/popular_movie/popular_movie_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_movie/popular_movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movie_cubit_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies
])
void main() {
  late PopularMovieCubit popularMovieCubit;
  late MockGetPopularMovies mockGetPopularMovies;
  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieCubit = PopularMovieCubit(mockGetPopularMovies);
  });

  test('initial state should be initial state', () {
    expect(popularMovieCubit.state, PopularMovieInitialState());
  });

  blocTest<PopularMovieCubit, PopularMovieState>(
    'Should emit [Loading, Error] when get popular movie is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMovieCubit;
    },
    act: (cubit) => cubit.fetchPopularMovies() ,
    expect: () => [
      PopularMovieLoading(),
      PopularMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMovieCubit, PopularMovieState>(
    'Should emit [Loading, Loaded] when get popular movie is successful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularMovieCubit;
    },
    act: (cubit) => cubit.fetchPopularMovies() ,
    expect: () => [
      PopularMovieLoading(),
      PopularMovieLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

}