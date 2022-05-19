
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_on_tv.dart';
import 'package:ditonton/presentation/cubit/popular_tv/popular_tv_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_tv/popular_tv_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_cubit_test.mocks.dart';

@GenerateMocks([
  GetPopularOnTv
])
void main() {
  late PopularTvCubit popularTvCubit;
  late MockGetPopularOnTv mockGetPopularOnTv;
  setUp(() {
    mockGetPopularOnTv = MockGetPopularOnTv();
    popularTvCubit = PopularTvCubit(mockGetPopularOnTv);
  });

  test('initial state should be initial state', () {
    expect(popularTvCubit.state, PopularTvInitialState());
  });

  blocTest<PopularTvCubit, PopularTvState>(
    'Should emit [Loading, Error] when get popular tv is unsuccessful',
    build: () {
      when(mockGetPopularOnTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvCubit;
    },
    act: (cubit) => cubit.fetchPopularOnTv() ,
    expect: () => [
      PopularTvLoading(),
      PopularTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularOnTv.execute());
    },
  );

  blocTest<PopularTvCubit, PopularTvState>(
    'Should emit [Loading, Loaded] when get popular tv is successful',
    build: () {
      when(mockGetPopularOnTv.execute())
          .thenAnswer((_) async => Right(testTvs));
      return popularTvCubit;
    },
    act: (cubit) => cubit.fetchPopularOnTv() ,
    expect: () => [
      PopularTvLoading(),
      PopularTvLoaded(testTvs),
    ],
    verify: (bloc) {
      verify(mockGetPopularOnTv.execute());
    },
  );

}