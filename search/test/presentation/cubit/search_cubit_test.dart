import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_on_tv.dart';
import 'package:search/presentation/cubit/search/search_cubit.dart';
import 'package:search/presentation/cubit/search/search_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_cubit_test.mocks.dart';


@GenerateMocks([SearchMovies, SearchOnTv])
void main() {
  late SearchCubit searchCubit;
  late MockSearchOnTv mockSearchOnTv;
  late MockSearchMovies mockSearchMovies;
  setUp(() {
    mockSearchOnTv = MockSearchOnTv();
    mockSearchMovies = MockSearchMovies();
    searchCubit = SearchCubit(mockSearchMovies, mockSearchOnTv);
  });
  const query = "spiderman";
  test('initial state should be initial state', () {
    expect(searchCubit.state, SearchInitialState());
  });

  blocTest<SearchCubit, SearchState>(
    'Should emit [Loading, Error] when search movie is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchCubit;
    },
    act: (cubit) => cubit.fetchMovieSearch(query),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );

  blocTest<SearchCubit, SearchState>(
    'Should emit [Loading, Loaded] when search movie is successful',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Right(testMovieList));
      return searchCubit;
    },
    act: (cubit) => cubit.fetchMovieSearch(query),
    expect: () => [
      SearchLoading(),
      SearchMovieLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );

  blocTest<SearchCubit, SearchState>(
    'Should emit [Loading, Error] when search tv is unsuccessful',
    build: () {
      when(mockSearchOnTv.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchCubit;
    },
    act: (cubit) => cubit.fetchTvSearch(query),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchOnTv.execute(query));
    },
  );

  blocTest<SearchCubit, SearchState>(
    'Should emit [Loading, Loaded] when search movie is successful',
    build: () {
      when(mockSearchOnTv.execute(query))
          .thenAnswer((_) async => Right(testTvs));
      return searchCubit;
    },
    act: (cubit) => cubit.fetchTvSearch(query),
    expect: () => [
      SearchLoading(),
      SearchTvLoaded(testTvs),
    ],
    verify: (bloc) {
      verify(mockSearchOnTv.execute(query));
    },
  );
}
