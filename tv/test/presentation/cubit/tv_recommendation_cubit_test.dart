
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_recommendation.dart';
import 'package:tv/presentation/cubit/tv_recommendation/tv_recommendation_cubit.dart';
import 'package:tv/presentation/cubit/tv_recommendation/tv_recommendation_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_recommendation_cubit_test.mocks.dart';


@GenerateMocks([
  GetTvRecommendations
])
void main() {
  late TvRecommendationCubit tvRecommendationCubit;
  late MockGetTvRecommendations mockGetTvRecommendations;
  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecommendationCubit = TvRecommendationCubit(mockGetTvRecommendations);
  });

  const int id = 1;
  test('initial state should be initial state', () {
    expect(tvRecommendationCubit.state, TvRecommendationInitialState());
  });

  blocTest<TvRecommendationCubit, TvRecommendationState>(
    'Should emit [Loading, Error] when get top rated tv is unsuccessful',
    build: () {
      when(mockGetTvRecommendations.execute(id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecommendationCubit;
    },
    act: (cubit) => cubit.fetchTvRecommendation(id),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(id));
    },
  );

  blocTest<TvRecommendationCubit, TvRecommendationState>(
    'Should emit [Loading, Loaded] when get popular tv is successful',
    build: () {
      when(mockGetTvRecommendations.execute(id))
          .thenAnswer((_) async => Right(testTvs));
      return tvRecommendationCubit;
    },
    act: (cubit) => cubit.fetchTvRecommendation(id),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationLoaded(testTvs),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(id));
    },
  );

}