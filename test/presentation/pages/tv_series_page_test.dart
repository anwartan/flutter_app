import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/tv_series_page.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_page_test.mocks.dart';

@GenerateMocks([TvSeriesListNotifier])
void main() {
  late MockTvSeriesListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(mockNotifier.popularState).thenReturn(RequestState.Loading);
        when(mockNotifier.onAirState).thenReturn(RequestState.Loading);
        when(mockNotifier.topRatedState).thenReturn(RequestState.Loading);

        final progressBarFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(TvSeriesPage()));

        expect(progressBarFinder, findsNWidgets(3));
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(mockNotifier.popularState).thenReturn(RequestState.Loaded);
        when(mockNotifier.popular).thenReturn(<Tv>[]);
        when(mockNotifier.onAirState).thenReturn(RequestState.Loaded);
        when(mockNotifier.onAir).thenReturn(<Tv>[]);
        when(mockNotifier.topRatedState).thenReturn(RequestState.Loaded);
        when(mockNotifier.topRated).thenReturn(<Tv>[]);

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TvSeriesPage()));

        expect(listViewFinder, findsNWidgets(3));
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(mockNotifier.popularState).thenReturn(RequestState.Error);
        when(mockNotifier.onAirState).thenReturn(RequestState.Error);
        when(mockNotifier.topRatedState).thenReturn(RequestState.Error);

        final textFinder = find.text('Failed');

        await tester.pumpWidget(_makeTestableWidget(TvSeriesPage()));

        expect(textFinder, findsNWidgets(3));
      });

  testWidgets('Page should display list view movie card  when data is loaded',
          (WidgetTester tester) async {
        when(mockNotifier.popularState).thenReturn(RequestState.Loaded);
        when(mockNotifier.popular).thenReturn(<Tv>[testTv]);
        when(mockNotifier.onAirState).thenReturn(RequestState.Loaded);
        when(mockNotifier.onAir).thenReturn(<Tv>[testTv]);
        when(mockNotifier.topRatedState).thenReturn(RequestState.Loaded);
        when(mockNotifier.topRated).thenReturn(<Tv>[testTv]);

        final listFinder = find.byType(TvSeriesList);

        await tester.pumpWidget(_makeTestableWidget(TvSeriesPage()));

        expect(listFinder, findsNWidgets(3));
      });
}
