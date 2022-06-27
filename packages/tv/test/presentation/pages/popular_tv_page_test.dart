import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/cubit/popular_tv/popular_tv_cubit.dart';
import 'package:tv/presentation/cubit/popular_tv/popular_tv_state.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_page_test.mocks.dart';

@GenerateMocks([PopularTvCubit])
void main() {
  late MockPopularTvCubit mockPopularTvCubit;

  setUp(() {
    mockPopularTvCubit = MockPopularTvCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvCubit>(
      create: (_) => mockPopularTvCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockPopularTvCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoading()));
    when(mockPopularTvCubit.state).thenReturn(PopularTvLoading());
    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularTvCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoaded(const <Tv>[])));
    when(mockPopularTvCubit.state).thenReturn(PopularTvLoaded(const <Tv>[]));
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockPopularTvCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvError('Error message')));
    when(mockPopularTvCubit.state).thenReturn(PopularTvError('Error message'));
    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
  testWidgets('Page should display list view movie card  when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularTvCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoaded(<Tv>[testTv])));
    when(mockPopularTvCubit.state).thenReturn(PopularTvLoaded(<Tv>[testTv]));

    final keyTvCardFinder = find.byKey(Key(testTv.id.toString()));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(keyTvCardFinder, findsOneWidget);
  });
}
