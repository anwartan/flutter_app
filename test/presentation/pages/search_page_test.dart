import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/enum.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_page_test.mocks.dart';

@GenerateMocks([TvSearchNotifier, MovieSearchNotifier])
void main() {
  late MockTvSearchNotifier mockTvSearchNotifier;
  late MockMovieSearchNotifier mockMovieSearchNotifier;

  setUp(() {
    mockTvSearchNotifier = MockTvSearchNotifier();
    mockMovieSearchNotifier = MockMovieSearchNotifier();
  });
  //
  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TvSearchNotifier>(
          create: (_) => mockTvSearchNotifier,
        ),
        ChangeNotifierProvider<MovieSearchNotifier>(
          create: (_) => mockMovieSearchNotifier,
        )
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar  when loading',
          (WidgetTester tester) async {
        when(mockTvSearchNotifier.state).thenReturn(RequestState.Loading);

        final progressFinder = find.byKey(Key("TV"));

        await tester.pumpWidget(_makeTestableWidget(SearchPage(type: Type.TV)));

        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(mockTvSearchNotifier.state).thenReturn(RequestState.Loaded);
        when(mockTvSearchNotifier.searchResult).thenReturn(<Tv>[]);

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(SearchPage(type: Type.TV)));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(mockTvSearchNotifier.state).thenReturn(RequestState.Error);
        when(mockTvSearchNotifier.message).thenReturn('Error message');

        final textFinder = find.byKey(Key('emptyContainerTv'));

        await tester.pumpWidget(_makeTestableWidget(SearchPage(type: Type.TV)));

        expect(textFinder, findsOneWidget);
      });
  testWidgets('Page should display list view movie card  when data is loaded',
          (WidgetTester tester) async {
        when(mockTvSearchNotifier.state).thenReturn(RequestState.Loaded);
        when(mockTvSearchNotifier.searchResult).thenReturn(<Tv>[testTv]);

        final keyTvCardFinder = find.byKey(Key(testTv.id.toString()));

        await tester.pumpWidget(_makeTestableWidget(SearchPage(type: Type.TV)));

        expect(keyTvCardFinder, findsOneWidget);
      });
}
