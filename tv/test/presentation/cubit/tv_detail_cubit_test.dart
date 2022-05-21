import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/presentation/cubit/tv_detail/tv_detail_cubit.dart';
import 'package:tv/presentation/cubit/tv_detail/tv_detail_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/tv_detail_notifier_test.mocks.dart';


@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailCubit tvDetailCubit;
  late MockGetTvDetail mockGetTvDetail;
  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailCubit = TvDetailCubit(mockGetTvDetail);
  });

  final int id = 1;
  test('initial state should be initial state', () {
    expect(tvDetailCubit.state, TvDetailInitialState());
  });

  blocTest<TvDetailCubit, TvDetailState>(
    'Should emit [Loading, Error] when get top rated tv is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailCubit;
    },
    act: (cubit) => cubit.fetchTvSeriesDetail(id),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
    },
  );

  blocTest<TvDetailCubit, TvDetailState>(
    'Should emit [Loading, Loaded] when get popular tv is successful',
    build: () {
      when(mockGetTvDetail.execute(id))
          .thenAnswer((_) async => Right(testTvDetail));
      return tvDetailCubit;
    },
    act: (cubit) => cubit.fetchTvSeriesDetail(id),
    expect: () => [
      TvDetailLoading(),
      TvDetailLoaded(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
    },
  );
}
