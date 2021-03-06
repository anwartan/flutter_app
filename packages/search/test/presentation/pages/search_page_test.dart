import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/cubit/search/search_cubit.dart';
import 'package:search/presentation/cubit/search/search_state.dart';
import 'package:search/presentation/pages/search_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_page_test.mocks.dart';


@GenerateMocks([SearchCubit])
void main() {
  late MockSearchCubit mockSearchCubit;

  setUp(() {
    mockSearchCubit = MockSearchCubit();
  });
  //
  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchCubit>(
      create: (_) => mockSearchCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar  when loading',
      (WidgetTester tester) async {
    when(mockSearchCubit.stream)
        .thenAnswer((_) => Stream.value(SearchLoading()));

    when(mockSearchCubit.state).thenReturn(SearchLoading());

    final progressFinder = find.byKey(const Key("TV"));

    await tester.pumpWidget(_makeTestableWidget(const SearchPage(type: Type.TV)));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded with type movie',
      (WidgetTester tester) async {
    when(mockSearchCubit.stream)
        .thenAnswer((_) => Stream.value(SearchMovieLoaded(<Movie>[testMovie])));
    when(mockSearchCubit.state).thenReturn(SearchMovieLoaded(<Movie>[testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage(type: Type.MOVIE)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded with type tv',
      (WidgetTester tester) async {
    when(mockSearchCubit.stream)
        .thenAnswer((_) => Stream.value(SearchTvLoaded(<Tv>[testTv])));
    when(mockSearchCubit.state).thenReturn(SearchTvLoaded(<Tv>[testTv]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage(type: Type.TV)));

    expect(listViewFinder, findsOneWidget);
  });
  testWidgets('Page should display when data is loaded with empty',
      (WidgetTester tester) async {
    when(mockSearchCubit.stream)
        .thenAnswer((_) => Stream.value(SearchTvLoaded(const <Tv>[])));
    when(mockSearchCubit.state).thenReturn(SearchTvLoaded(const <Tv>[]));
    final listViewFinder = find.byKey(const Key("empty"));

    await tester.pumpWidget(_makeTestableWidget(const SearchPage(type: Type.TV)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockSearchCubit.stream)
        .thenAnswer((_) => Stream.value(SearchError("failed")));
    when(mockSearchCubit.state).thenReturn(SearchError("failed"));

    final textFinder = find.byKey(const Key('emptyContainerTv'));

    await tester.pumpWidget(_makeTestableWidget(const SearchPage(type: Type.TV)));

    expect(textFinder, findsOneWidget);
  });
  testWidgets('Page should display list view movie card  when data is loaded',
      (WidgetTester tester) async {
    when(mockSearchCubit.stream)
        .thenAnswer((_) => Stream.value(SearchTvLoaded(<Tv>[testTv])));
    when(mockSearchCubit.state).thenReturn(SearchTvLoaded(<Tv>[testTv]));

    final keyTvCardFinder = find.byKey(Key(testTv.id.toString()));

    await tester.pumpWidget(_makeTestableWidget(const SearchPage(type: Type.TV)));

    expect(keyTvCardFinder, findsOneWidget);
  });
}
