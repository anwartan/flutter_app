import 'package:core/domain/entities/watch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watch/presentation/cubic/watch/watch_cubit.dart';
import 'package:watch/presentation/cubic/watch/watch_state.dart';
import 'package:watch/presentation/pages/watchlist_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_page_test.mocks.dart';


@GenerateMocks([WatchCubit])
void main() {
  late MockWatchCubit mockWatchCubit;

  setUp(() {
    mockWatchCubit = MockWatchCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchCubit>(
      create: (_) => mockWatchCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockWatchCubit.stream).thenAnswer((_) => Stream.value(WatchLoading()));
    when(mockWatchCubit.state).thenReturn(WatchLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchListLoaded(<Watch>[testWatch])));
    when(mockWatchCubit.state).thenReturn(WatchListLoaded(<Watch>[testWatch]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });
  testWidgets('Page should display ListView when data is loaded with empty',
      (WidgetTester tester) async {
    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchListLoaded(const <Watch>[])));
    when(mockWatchCubit.state).thenReturn(WatchListLoaded(const <Watch>[]));

    final listViewFinder = find.byKey(const Key("empty"));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });
  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchError('Error message')));
    when(mockWatchCubit.state).thenReturn(WatchError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display list view movie card  when data is loaded',
      (WidgetTester tester) async {
    when(mockWatchCubit.stream)
        .thenAnswer((_) => Stream.value(WatchListLoaded(<Watch>[testWatch])));
    when(mockWatchCubit.state).thenReturn(WatchListLoaded(<Watch>[testWatch]));

    final keyWatchCardFinder = find.byKey(Key(testWatch.refId.toString()));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(keyWatchCardFinder, findsOneWidget);
  });
}
