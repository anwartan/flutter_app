import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/watch.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieNotifier])
void main() {
  late MockWatchlistMovieNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistMovieNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistMovieNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(mockNotifier.watchlistState).thenReturn(RequestState.Loading);

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
        when(mockNotifier.watchlist).thenReturn(<Watch>[testWatch]);

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });
  testWidgets('Page should display ListView when data is loaded with empty',
          (WidgetTester tester) async {
        when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
        when(mockNotifier.watchlist).thenReturn(<Watch>[]);

        final listViewFinder = find.byKey(Key("empty"));

        await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });
  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(mockNotifier.watchlistState).thenReturn(RequestState.Error);
        when(mockNotifier.message).thenReturn('Error message');

        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

        expect(textFinder, findsOneWidget);
      });

  testWidgets('Page should display list view movie card  when data is loaded',
          (WidgetTester tester) async {
        when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
        when(mockNotifier.watchlist).thenReturn(<Watch>[testWatch]);

        final keyWatchCardFinder = find.byKey(Key(testWatch.refId.toString()));

        await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

        expect(keyWatchCardFinder, findsOneWidget);
      });
}
