import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/movie_detail/movie_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailCubit movieDetailCubit;
  late MockGetMovieDetail mockGetMovieDetail;
  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailCubit = MovieDetailCubit(getMovieDetail: mockGetMovieDetail);
  });
  final tId = 1;

  test('initial state should be initial state', () {
    expect(movieDetailCubit.state, MovieDetailEmpty());
  });

  blocTest<MovieDetailCubit, MovieDetailState>(
    'Should emit [Loading, Error] when get movie detail is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieDetailCubit;
    },
    act: (cubit) => cubit.fetchMovieDetail(tId) ,
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );

  blocTest<MovieDetailCubit, MovieDetailState>(
    'Should emit [Loading, Loaded] when get recommendation is successful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return movieDetailCubit;
    },
    act: (cubit) => cubit.fetchMovieDetail(tId) ,
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );
}
