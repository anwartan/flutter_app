import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/cubit/on_air_tv/on_air_tv_cubit.dart';
import 'package:ditonton/presentation/cubit/on_air_tv/on_air_tv_state.dart';
import 'package:ditonton/presentation/cubit/popular_tv/popular_tv_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_tv/popular_tv_state.dart';
import 'package:ditonton/presentation/cubit/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:ditonton/presentation/cubit/top_rated_tv/top_rated_tv_state.dart';
import 'package:ditonton/presentation/pages/tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_page_test.mocks.dart';

@GenerateMocks([OnAirTvCubit, PopularTvCubit, TopRatedTvCubit])
void main() {
  late MockOnAirTvCubit mockOnAirTvCubit;
  late MockPopularTvCubit mockPopularTvCubit;
  late MockTopRatedTvCubit mockTopRatedTvCubit;
  setUp(() {
    mockOnAirTvCubit = MockOnAirTvCubit();
    mockPopularTvCubit = MockPopularTvCubit();
    mockTopRatedTvCubit = MockTopRatedTvCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
        providers: [
          BlocProvider<OnAirTvCubit>(create: (_) => mockOnAirTvCubit),
          BlocProvider<PopularTvCubit>(create: (_) => mockPopularTvCubit),
          BlocProvider<TopRatedTvCubit>(create: (_) => mockTopRatedTvCubit),
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockOnAirTvCubit.stream)
        .thenAnswer((_) => Stream.value(OnAirTvLoading()));
    when(mockOnAirTvCubit.state).thenReturn(OnAirTvLoading());
    when(mockPopularTvCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoading()));
    when(mockPopularTvCubit.state).thenReturn(PopularTvLoading());
    when(mockTopRatedTvCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvLoading()));
    when(mockTopRatedTvCubit.state).thenReturn(TopRatedTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesPage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockOnAirTvCubit.stream)
        .thenAnswer((_) => Stream.value(OnAirTvLoaded(<Tv>[])));
    when(mockOnAirTvCubit.state).thenReturn(OnAirTvLoaded(<Tv>[]));
    when(mockPopularTvCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoaded(<Tv>[])));
    when(mockPopularTvCubit.state).thenReturn(PopularTvLoaded(<Tv>[]));
    when(mockTopRatedTvCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvLoaded(<Tv>[])));
    when(mockTopRatedTvCubit.state).thenReturn(TopRatedTvLoaded(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesPage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockOnAirTvCubit.stream)
        .thenAnswer((_) => Stream.value(OnAirTvError('failed')));
    when(mockOnAirTvCubit.state).thenReturn(OnAirTvError('failed'));
    when(mockPopularTvCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvError('failed')));
    when(mockPopularTvCubit.state).thenReturn(PopularTvError('failed'));
    when(mockTopRatedTvCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvError('failed')));
    when(mockTopRatedTvCubit.state).thenReturn(TopRatedTvError('failed'));

    final textFinder = find.text('Failed');

    await tester.pumpWidget(_makeTestableWidget(TvSeriesPage()));

    expect(textFinder, findsNWidgets(3));
  });

  testWidgets('Page should display list view movie card  when data is loaded',
      (WidgetTester tester) async {
    when(mockOnAirTvCubit.stream)
        .thenAnswer((_) => Stream.value(OnAirTvLoaded(<Tv>[testTv])));
    when(mockOnAirTvCubit.state).thenReturn(OnAirTvLoaded(<Tv>[testTv]));
    when(mockPopularTvCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoaded(<Tv>[testTv])));
    when(mockPopularTvCubit.state).thenReturn(PopularTvLoaded(<Tv>[testTv]));
    when(mockTopRatedTvCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvLoaded(<Tv>[testTv])));
    when(mockTopRatedTvCubit.state).thenReturn(TopRatedTvLoaded(<Tv>[testTv]));

    final listFinder = find.byType(TvSeriesList);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesPage()));

    expect(listFinder, findsNWidgets(3));
  });
}
