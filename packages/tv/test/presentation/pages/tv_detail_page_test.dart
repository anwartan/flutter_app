import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/cubit/tv_detail/tv_detail_cubit.dart';
import 'package:tv/presentation/cubit/tv_detail/tv_detail_state.dart';
import 'package:tv/presentation/cubit/tv_recommendation/tv_recommendation_cubit.dart';
import 'package:tv/presentation/cubit/tv_recommendation/tv_recommendation_state.dart';
import 'package:tv/presentation/cubit/tv_season/tv_season_cubit.dart';
import 'package:tv/presentation/cubit/tv_season/tv_season_state.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:watch/presentation/cubic/watch/watch_cubit.dart';
import 'package:watch/presentation/cubic/watch/watch_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks(
    [TvDetailCubit, WatchCubit, TvRecommendationCubit, TvSeasonCubit])
void main() {
  late MockTvDetailCubit mockTvDetailCubit;
  late MockWatchCubit mockWatchCubit;
  late MockTvRecommendationCubit mockTvRecommendationCubit;
  late MockTvSeasonCubit mockTvSeasonCubit;
  setUp(() {
    mockTvDetailCubit = MockTvDetailCubit();
    mockWatchCubit = MockWatchCubit();
    mockTvRecommendationCubit = MockTvRecommendationCubit();
    mockTvSeasonCubit = MockTvSeasonCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TvDetailCubit>(create: (_) => mockTvDetailCubit),
        BlocProvider<WatchCubit>(create: (_) => mockWatchCubit),
        BlocProvider<TvRecommendationCubit>(
            create: (_) => mockTvRecommendationCubit),
        BlocProvider<TvSeasonCubit>(create: (_) => mockTvSeasonCubit),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const tIdSeason = 1;
  final tListEpisode = <Episode>[];
  testWidgets('Image shoud display ', (WidgetTester tester) async {
    when(mockTvDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvDetailLoaded(testTvDetail)));
    when(mockTvDetailCubit.state).thenReturn(TvDetailLoaded(testTvDetail));

    when(mockTvRecommendationCubit.stream)
        .thenAnswer((_) => Stream.value(TvRecommendationLoaded(const <Tv>[])));
    when(mockTvRecommendationCubit.state)
        .thenReturn(TvRecommendationLoaded(const <Tv>[]));

    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchCheckAdded(false)));
    when(mockWatchCubit.state).thenReturn(WatchCheckAdded(false));

    when(mockTvSeasonCubit.stream).thenAnswer(
        (_) => Stream.value(TvSeasonLoaded(tIdSeason, tListEpisode)));
    when(mockTvSeasonCubit.state)
        .thenReturn(TvSeasonLoaded(tIdSeason, tListEpisode));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockTvDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvDetailLoaded(testTvDetail)));
    when(mockTvDetailCubit.state).thenReturn(TvDetailLoaded(testTvDetail));

    when(mockTvRecommendationCubit.stream)
        .thenAnswer((_) => Stream.value(TvRecommendationLoaded(const <Tv>[])));
    when(mockTvRecommendationCubit.state)
        .thenReturn(TvRecommendationLoaded(const <Tv>[]));

    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchCheckAdded(true)));
    when(mockWatchCubit.state).thenReturn(WatchCheckAdded(true));

    when(mockTvSeasonCubit.stream).thenAnswer(
        (_) => Stream.value(TvSeasonLoaded(tIdSeason, tListEpisode)));
    when(mockTvSeasonCubit.state)
        .thenReturn(TvSeasonLoaded(tIdSeason, tListEpisode));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockTvDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvDetailLoaded(testTvDetail)));
    when(mockTvDetailCubit.state).thenReturn(TvDetailLoaded(testTvDetail));

    when(mockTvRecommendationCubit.stream)
        .thenAnswer((_) => Stream.value(TvRecommendationLoaded(const <Tv>[])));
    when(mockTvRecommendationCubit.state)
        .thenReturn(TvRecommendationLoaded(const <Tv>[]));

    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchCheckAdded(false)));
    when(mockWatchCubit.state).thenReturn(WatchCheckAdded(false));
    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchMessage('Added to Watchlist')));
    when(mockWatchCubit.state).thenReturn(WatchMessage('Added to Watchlist'));
    when(mockTvSeasonCubit.stream).thenAnswer(
        (_) => Stream.value(TvSeasonLoaded(tIdSeason, tListEpisode)));
    when(mockTvSeasonCubit.state)
        .thenReturn(TvSeasonLoaded(tIdSeason, tListEpisode));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockTvDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvDetailLoaded(testTvDetail)));
    when(mockTvDetailCubit.state).thenReturn(TvDetailLoaded(testTvDetail));

    when(mockTvRecommendationCubit.stream)
        .thenAnswer((_) => Stream.value(TvRecommendationLoaded(const <Tv>[])));
    when(mockTvRecommendationCubit.state)
        .thenReturn(TvRecommendationLoaded(const <Tv>[]));

    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchCheckAdded(false)));
    when(mockWatchCubit.state).thenReturn(WatchCheckAdded(false));
    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchError('Failed')));
    when(mockWatchCubit.state).thenReturn(WatchError('Failed'));
    when(mockTvSeasonCubit.stream).thenAnswer(
        (_) => Stream.value(TvSeasonLoaded(tIdSeason, tListEpisode)));
    when(mockTvSeasonCubit.state)
        .thenReturn(TvSeasonLoaded(tIdSeason, tListEpisode));


    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'recommendation should display empty container when RequestState is initial state',
      (WidgetTester tester) async {
    when(mockTvDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvDetailLoaded(testTvDetail)));
    when(mockTvDetailCubit.state).thenReturn(TvDetailLoaded(testTvDetail));

    when(mockTvRecommendationCubit.stream)
        .thenAnswer((_) => Stream.value(TvRecommendationInitialState()));
    when(mockTvRecommendationCubit.state)
        .thenReturn(TvRecommendationInitialState());

    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchCheckAdded(false)));
    when(mockWatchCubit.state).thenReturn(WatchCheckAdded(false));
    when(mockTvSeasonCubit.stream).thenAnswer(
        (_) => Stream.value(TvSeasonLoaded(tIdSeason, tListEpisode)));
    when(mockTvSeasonCubit.state)
        .thenReturn(TvSeasonLoaded(tIdSeason, tListEpisode));

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));
    await tester.drag(
        find.byType(SingleChildScrollView).first, const Offset(500.0, 0.0));
    await tester.pump();
    final expected = find.byKey(const Key("EmptyContainer"));
    expect(expected, findsOneWidget);
  });
}
