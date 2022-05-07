

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Image shoud display ',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
        when(mockNotifier.seasons).thenReturn(Map());

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);
        when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
        when(mockNotifier.seasons).thenReturn(Map());
        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');
        when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
        when(mockNotifier.seasons).thenReturn(Map());
        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn('Failed');
        when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
        when(mockNotifier.seasons).thenReturn(Map());
        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });

  testWidgets(
      'recommendation should display empty container when RequestState is empty',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
        when(mockNotifier.seasons).thenReturn(Map());
        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
        await tester.drag(find.byType(SingleChildScrollView).first, const Offset(500.0, 0.0));
        await tester.pump();
        final expected = find.byKey(Key("EmptyContainer"));
        expect(expected, findsOneWidget);
      });

}
