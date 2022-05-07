import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/on_air_tv_page.dart';
import 'package:ditonton/presentation/provider/on_air_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_air_tv_page_test.mocks.dart';

@GenerateMocks([OnAirTvNotifier])
void main() {
  late MockOnAirTvNotifier mockOnAirTvNotifier;

  setUp(() {
    mockOnAirTvNotifier = MockOnAirTvNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<OnAirTvNotifier>.value(
      value: mockOnAirTvNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(mockOnAirTvNotifier.state).thenReturn(RequestState.Loading);

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(mockOnAirTvNotifier.state).thenReturn(RequestState.Loaded);
        when(mockOnAirTvNotifier.tv).thenReturn(<Tv>[]);

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(mockOnAirTvNotifier.state).thenReturn(RequestState.Error);
        when(mockOnAirTvNotifier.message).thenReturn('Error message');

        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

        expect(textFinder, findsOneWidget);
      });

  testWidgets('Page should display list view movie card  when data is loaded',
          (WidgetTester tester) async {
        when(mockOnAirTvNotifier.state).thenReturn(RequestState.Loaded);
        when(mockOnAirTvNotifier.tv).thenReturn(<Tv>[testTv]);

        final keytTvCardFinder = find.byKey(Key(testTv.id.toString()));

        await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

        expect(keytTvCardFinder, findsOneWidget);
      });
}
