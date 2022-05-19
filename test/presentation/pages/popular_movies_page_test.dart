import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/cubit/popular_movie/popular_movie_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_movie/popular_movie_state.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMovieCubit])
void main() {
  late MockPopularMovieCubit mockPopularMovieCubit;

  setUp(() {
    mockPopularMovieCubit = MockPopularMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieCubit>(
      create: (_) => mockPopularMovieCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockPopularMovieCubit.stream)
        .thenAnswer((_)=>Stream.value(PopularMovieLoading()));
    when(mockPopularMovieCubit.state).thenReturn(PopularMovieLoading());
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularMovieCubit.stream)
        .thenAnswer((_)=>Stream.value(PopularMovieLoaded(<Movie>[])));
    when(mockPopularMovieCubit.state).thenReturn(PopularMovieLoaded(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockPopularMovieCubit.stream)
        .thenAnswer((_)=>Stream.value(PopularMovieError('Error message')));
    when(mockPopularMovieCubit.state)
        .thenReturn(PopularMovieError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display list view movie card  when data is loaded',
      (WidgetTester tester) async {
        when(mockPopularMovieCubit.stream)
            .thenAnswer((_)=>Stream.value(PopularMovieLoaded(<Movie>[testMovie])));
        when(mockPopularMovieCubit.state).thenReturn(PopularMovieLoaded(<Movie>[testMovie]));

    final keyMovieCardFinder = find.byKey(Key(testMovie.id.toString()));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(keyMovieCardFinder, findsOneWidget);
  });
}
