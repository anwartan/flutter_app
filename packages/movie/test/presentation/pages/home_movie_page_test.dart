import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/cubit/now_playing_movie/now_playing_movie_cubit.dart';
import 'package:movie/presentation/cubit/now_playing_movie/now_playing_movie_state.dart';
import 'package:movie/presentation/cubit/popular_movie/popular_movie_cubit.dart';
import 'package:movie/presentation/cubit/popular_movie/popular_movie_state.dart';
import 'package:movie/presentation/cubit/top_rated_movie/top_rated_movie_cubit.dart';
import 'package:movie/presentation/cubit/top_rated_movie/top_rated_movie_state.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_movie_page_test.mocks.dart';


@GenerateMocks([NowPlayingMovieCubit, TopRatedMovieCubit, PopularMovieCubit])
void main() {
  late MockNowPlayingMovieCubit mockNowPlayingMovieCubit;
  late MockTopRatedMovieCubit mockTopRatedMovieCubit;
  late MockPopularMovieCubit mockPopularMovieCubit;

  setUp(() {
    mockNowPlayingMovieCubit = MockNowPlayingMovieCubit();
    mockTopRatedMovieCubit = MockTopRatedMovieCubit();
    mockPopularMovieCubit = MockPopularMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<NowPlayingMovieCubit>(
            create: (_) => mockNowPlayingMovieCubit),
        BlocProvider<TopRatedMovieCubit>(create: (_) => mockTopRatedMovieCubit),
        BlocProvider<PopularMovieCubit>(create: (_) => mockPopularMovieCubit),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNowPlayingMovieCubit.stream)
        .thenAnswer((_) => Stream.value(NowPlayingMovieLoading()));
    when(mockPopularMovieCubit.stream)
        .thenAnswer((_) => Stream.value(PopularMovieLoading()));
    when(mockTopRatedMovieCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieLoading()));
    when(mockNowPlayingMovieCubit.state).thenReturn(NowPlayingMovieLoading());
    when(mockPopularMovieCubit.state).thenReturn(PopularMovieLoading());
    when(mockTopRatedMovieCubit.state).thenReturn(TopRatedMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNowPlayingMovieCubit.stream)
        .thenAnswer((_) => Stream.value(NowPlayingMovieLoaded(const <Movie>[])));
    when(mockPopularMovieCubit.stream)
        .thenAnswer((_) => Stream.value(PopularMovieLoaded(const <Movie>[])));
    when(mockTopRatedMovieCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieLoaded(const <Movie>[])));
    when(mockNowPlayingMovieCubit.state)
        .thenReturn(NowPlayingMovieLoaded(const <Movie>[]));
    when(mockPopularMovieCubit.state).thenReturn(PopularMovieLoaded(const <Movie>[]));
    when(mockTopRatedMovieCubit.state)
        .thenReturn(TopRatedMovieLoaded(const <Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNowPlayingMovieCubit.stream).thenAnswer(
        (_) => Stream.value(NowPlayingMovieError("Server Failure")));
    when(mockPopularMovieCubit.stream)
        .thenAnswer((_) => Stream.value(PopularMovieError("Server Failure")));
    when(mockTopRatedMovieCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieError("Server Failure")));
    when(mockNowPlayingMovieCubit.state)
        .thenReturn(NowPlayingMovieError("Server Failure"));
    when(mockPopularMovieCubit.state)
        .thenReturn(PopularMovieError("Server Failure"));
    when(mockTopRatedMovieCubit.state)
        .thenReturn(TopRatedMovieError("Server Failure"));
    final textFinder = find.text('Failed');

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(textFinder, findsNWidgets(3));
  });

  testWidgets('Page should display list view movie card  when data is loaded',
      (WidgetTester tester) async {
    when(mockNowPlayingMovieCubit.stream).thenAnswer(
        (_) => Stream.value(NowPlayingMovieLoaded(<Movie>[testMovie])));
    when(mockPopularMovieCubit.stream).thenAnswer(
        (_) => Stream.value(PopularMovieLoaded(<Movie>[testMovie])));
    when(mockTopRatedMovieCubit.stream).thenAnswer(
        (_) => Stream.value(TopRatedMovieLoaded(<Movie>[testMovie])));
    when(mockNowPlayingMovieCubit.state)
        .thenReturn(NowPlayingMovieLoaded(<Movie>[testMovie]));
    when(mockPopularMovieCubit.state)
        .thenReturn(PopularMovieLoaded(<Movie>[testMovie]));
    when(mockTopRatedMovieCubit.state)
        .thenReturn(TopRatedMovieLoaded(<Movie>[testMovie]));

    final listFinder = find.byType(MovieList);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(listFinder, findsNWidgets(3));
  });
}
