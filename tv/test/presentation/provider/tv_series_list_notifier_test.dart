import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/domain/usecases/get_now_playing_on_tv.dart';
import 'package:tv/domain/usecases/get_popular_on_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_on_tv.dart';
import 'package:tv/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_air_tv_notifier_test.mocks.dart';
import 'popular_tv_notifier_test.mocks.dart';
import 'top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingOnTv,GetPopularOnTv,GetTopRatedOnTv])
void main() {
  late MockGetPopularOnTv mockGetPopularOnTv;
  late MockGetNowPlayingOnTv mockGetNowPlayingOnTv;
  late MockGetTopRatedOnTv mockGetTopRatedOnTv;
  late TvSeriesListNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularOnTv = MockGetPopularOnTv();
    mockGetNowPlayingOnTv = MockGetNowPlayingOnTv();
    mockGetTopRatedOnTv = MockGetTopRatedOnTv();
    notifier = TvSeriesListNotifier(getPopularOnTv: mockGetPopularOnTv,getNowPlayingOnTv: mockGetNowPlayingOnTv,getTopRatedOnTv: mockGetTopRatedOnTv)
      ..addListener(() {
        listenerCallCount++;
      });
  });


  final tTvList = <Tv>[testTv];
  test('should change state popular to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularOnTv.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchPopularOnTv();
    // assert
    expect(notifier.popularState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change state on air to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingOnTv.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchNowPlayingOnTv();
    // assert
    expect(notifier.onAirState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });
  test('should change state top rated tv to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedOnTv.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchTopRatedOnTv();
    // assert
    expect(notifier.topRatedState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change popular tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularOnTv.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchPopularOnTv();
    // assert
    expect(notifier.popularState, RequestState.Loaded);
    expect(notifier.popular, tTvList);
    expect(listenerCallCount, 2);
  });
  test('should change on air tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingOnTv.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchNowPlayingOnTv();
    // assert
    expect(notifier.onAirState, RequestState.Loaded);
    expect(notifier.onAir, tTvList);
    expect(listenerCallCount, 2);
  });
  test('should change on top rated tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedOnTv.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchTopRatedOnTv();
    // assert
    expect(notifier.topRatedState, RequestState.Loaded);
    expect(notifier.topRated, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return popular error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularOnTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularOnTv();
    // assert
    expect(notifier.popularState, RequestState.Error);
    expect(notifier.popularMessage, 'Server Failure');
    expect(listenerCallCount, 2);
  });
  test('should return on air error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingOnTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlayingOnTv();
    // assert
    expect(notifier.onAirState, RequestState.Error);
    expect(notifier.onAirMessage, 'Server Failure');
    expect(listenerCallCount, 2);
  });

  test('should return top rated tv error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedOnTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedOnTv();
    // assert
    expect(notifier.topRatedState, RequestState.Error);
    expect(notifier.topRatedMessage, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
