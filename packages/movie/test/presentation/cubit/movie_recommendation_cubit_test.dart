import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/get_movie_recommendations.dart';
import 'package:movie/presentation/cubit/movie_recommendation/movie_recommendation_cubit.dart';
import 'package:movie/presentation/cubit/movie_recommendation/movie_recommendation_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieRecommendations,
])
void main() {
  late MovieRecommendationCubit movieRecommendationCubit;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationCubit = MovieRecommendationCubit(
        getMovieRecommendations: mockGetMovieRecommendations);
  });
  const tId = 1;
  final tListMovie = <Movie>[testMovie];

  test('initial state should be initial state', () {
    expect(movieRecommendationCubit.state, MovieRecommendationInitialState());
  });

  blocTest<MovieRecommendationCubit, MovieRecommendationState>(
    'Should emit [Loading, Error] when get recommendation is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieRecommendationCubit;
    },
    act: (cubit) => cubit.fetchMovieRecommendations(tId) ,
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieRecommendationCubit, MovieRecommendationState>(
    'Should emit [Loading, Loaded] when get recommendation is successful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tListMovie));
      return movieRecommendationCubit;
    },
    act: (cubit) => cubit.fetchMovieRecommendations(tId) ,
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationLoaded(tListMovie),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );
}
