import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:movie/presentation/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:movie/presentation/cubit/movie_detail/movie_detail_state.dart';import 'package:movie/presentation/cubit/movie_recommendation/movie_recommendation_cubit.dart';
import 'package:movie/presentation/cubit/movie_recommendation/movie_recommendation_state.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:watch/presentation/cubic/watch/watch_cubit.dart';
import 'package:watch/presentation/cubic/watch/watch_state.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';


@GenerateMocks([MovieDetailCubit, MovieRecommendationCubit, WatchCubit])
void main() {
  late MockMovieDetailCubit mockMovieDetailCubit;
  late MockMovieRecommendationCubit mockMovieRecommendationCubit;
  late MockWatchCubit mockWatchCubit;

  setUp(() {
    mockMovieDetailCubit = MockMovieDetailCubit();
    mockMovieRecommendationCubit = MockMovieRecommendationCubit();
    mockWatchCubit = MockWatchCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieDetailCubit>(create: (_) => mockMovieDetailCubit),
        BlocProvider<MovieRecommendationCubit>(
            create: (_) => mockMovieRecommendationCubit),
        BlocProvider<WatchCubit>(create: (_) => mockWatchCubit),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Image shoud display ', (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(testMovieDetail)));
    when(mockMovieRecommendationCubit.stream)
        .thenAnswer((_) => Stream.value(MovieRecommendationLoaded(const <Movie>[])));
    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchCheckAdded(false)));
    when(mockMovieDetailCubit.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(mockMovieRecommendationCubit.state)
        .thenReturn(MovieRecommendationLoaded(const <Movie>[]));
    when(mockWatchCubit.state).thenReturn(WatchCheckAdded(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(testMovieDetail)));
    when(mockMovieRecommendationCubit.stream)
        .thenAnswer((_) => Stream.value(MovieRecommendationLoaded(const <Movie>[])));
    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchCheckAdded(false)));
    when(mockMovieDetailCubit.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(mockMovieRecommendationCubit.state)
        .thenReturn(MovieRecommendationLoaded(const <Movie>[]));
    when(mockWatchCubit.state).thenReturn(WatchCheckAdded(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(testMovieDetail)));
    when(mockMovieRecommendationCubit.stream)
        .thenAnswer((_) => Stream.value(MovieRecommendationLoaded(const <Movie>[])));
    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchCheckAdded(false)));
    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchMessage('Added to Watchlist')));
    when(mockMovieDetailCubit.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(mockMovieRecommendationCubit.state)
        .thenReturn(MovieRecommendationLoaded(const <Movie>[]));
    when(mockWatchCubit.state).thenReturn(WatchCheckAdded(false));
    when(mockWatchCubit.state).thenReturn(WatchMessage('Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));

    when(mockMovieRecommendationCubit.state)
        .thenReturn(MovieRecommendationLoaded(const <Movie>[]));
    when(mockMovieRecommendationCubit.stream)
        .thenAnswer((_) => Stream.value(MovieRecommendationLoaded(const <Movie>[])));

    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchCheckAdded(false)));
    when(mockWatchCubit.state).thenReturn(WatchCheckAdded(false));

    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchError('failed')));
    when(mockWatchCubit.state).thenReturn(WatchError('failed'));


    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('failed'), findsOneWidget);
  });

  testWidgets(
      'recommendation should display empty container when RequestState is initial state',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(testMovieDetail)));
    when(mockMovieRecommendationCubit.stream)
        .thenAnswer((_) => Stream.value(MovieRecommendationInitialState()));
    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchCheckAdded(false)));
    when(mockMovieDetailCubit.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(mockMovieRecommendationCubit.state)
        .thenReturn(MovieRecommendationInitialState());
    when(mockWatchCubit.state).thenReturn(WatchCheckAdded(false));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.drag(
        find.byType(SingleChildScrollView).first, const Offset(500.0, 0.0));
    await tester.pump();
    final expected = find.byKey(const Key("EmptyContainer"));
    expect(expected, findsOneWidget);
  });
}
