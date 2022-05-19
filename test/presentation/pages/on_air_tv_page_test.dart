import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/cubit/on_air_tv/on_air_tv_cubit.dart';
import 'package:ditonton/presentation/cubit/on_air_tv/on_air_tv_state.dart';
import 'package:ditonton/presentation/pages/on_air_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_air_tv_page_test.mocks.dart';

@GenerateMocks([OnAirTvCubit])
void main() {
  late MockOnAirTvCubit mockOnAirTvCubit;

  setUp(() {
    mockOnAirTvCubit = MockOnAirTvCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnAirTvCubit>(
        create: (_) => mockOnAirTvCubit,
        child: MaterialApp(
          home: body,
        ));
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockOnAirTvCubit.stream)
        .thenAnswer((_) => Stream.value(OnAirTvLoading()));
    when(mockOnAirTvCubit.state).thenReturn(OnAirTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockOnAirTvCubit.stream)
        .thenAnswer((_) => Stream.value(OnAirTvLoaded(<Tv>[])));
    when(mockOnAirTvCubit.state).thenReturn(OnAirTvLoaded(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockOnAirTvCubit.stream)
        .thenAnswer((_) => Stream.value(OnAirTvError("Error message")));
    when(mockOnAirTvCubit.state).thenReturn(OnAirTvError("Error message"));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display list view movie card  when data is loaded',
      (WidgetTester tester) async {
    when(mockOnAirTvCubit.stream)
        .thenAnswer((_) => Stream.value(OnAirTvLoaded(<Tv>[testTv])));
    when(mockOnAirTvCubit.state).thenReturn(OnAirTvLoaded(<Tv>[testTv]));

    final keytTvCardFinder = find.byKey(Key(testTv.id.toString()));

    await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

    expect(keytTvCardFinder, findsOneWidget);
  });
}
