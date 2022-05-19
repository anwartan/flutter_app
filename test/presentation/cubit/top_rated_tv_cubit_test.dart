
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_on_tv.dart';
import 'package:ditonton/presentation/cubit/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:ditonton/presentation/cubit/top_rated_tv/top_rated_tv_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_cubit_test.mocks.dart';

@GenerateMocks([
  GetTopRatedOnTv
])
void main() {
  late TopRatedTvCubit topRatedTvCubit;
  late MockGetTopRatedOnTv mockGetTopRatedOnTv;
  setUp(() {
    mockGetTopRatedOnTv = MockGetTopRatedOnTv();
    topRatedTvCubit = TopRatedTvCubit(mockGetTopRatedOnTv);
  });

  test('initial state should be initial state', () {
    expect(topRatedTvCubit.state, TopRatedTvInitialState());
  });

  blocTest<TopRatedTvCubit, TopRatedTvState>(
    'Should emit [Loading, Error] when get top rated tv is unsuccessful',
    build: () {
      when(mockGetTopRatedOnTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvCubit;
    },
    act: (cubit) => cubit.fetchTopRatedTv(),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedOnTv.execute());
    },
  );

  blocTest<TopRatedTvCubit, TopRatedTvState>(
    'Should emit [Loading, Loaded] when get popular tv is successful',
    build: () {
      when(mockGetTopRatedOnTv.execute())
          .thenAnswer((_) async => Right(testTvs));
      return topRatedTvCubit;
    },
    act: (cubit) => cubit.fetchTopRatedTv(),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvLoaded(testTvs),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedOnTv.execute());
    },
  );

}