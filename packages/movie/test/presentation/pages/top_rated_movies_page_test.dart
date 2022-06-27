import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/cubit/top_rated_movie/top_rated_movie_cubit.dart';
import 'package:movie/presentation/cubit/top_rated_movie/top_rated_movie_state.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_page_test.mocks.dart';


@GenerateMocks([TopRatedMovieCubit])
void main() {
  late MockTopRatedMovieCubit mockTopRatedMovieCubit;

  setUp(() {
    mockTopRatedMovieCubit = MockTopRatedMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieCubit>(
      create: (_) => mockTopRatedMovieCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockTopRatedMovieCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieLoading()));

    when(mockTopRatedMovieCubit.state).thenReturn(TopRatedMovieLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockTopRatedMovieCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieLoaded(const <Movie>[])));
    when(mockTopRatedMovieCubit.state)
        .thenReturn(TopRatedMovieLoaded(const <Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTopRatedMovieCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieError('Error message')));
    when(mockTopRatedMovieCubit.state)
        .thenReturn(TopRatedMovieError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
  testWidgets('Page should display list view movie card  when data is loaded',
      (WidgetTester tester) async {
    when(mockTopRatedMovieCubit.stream).thenAnswer(
        (_) => Stream.value(TopRatedMovieLoaded(<Movie>[testMovie])));
    when(mockTopRatedMovieCubit.state)
        .thenReturn(TopRatedMovieLoaded(<Movie>[testMovie]));

    final keyMovieCardFinder = find.byKey(Key(testMovie.id.toString()));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(keyMovieCardFinder, findsOneWidget);
  });
}
