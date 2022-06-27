import 'package:core/core.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/watch.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_episode_tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendation.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';
import 'package:watch/domain/get_watchlist_status.dart';
import 'package:watch/domain/remove_watchlist.dart';
import 'package:watch/domain/save_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetEpisodeTv,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetEpisodeTv mockGetEpisodeTv;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  late int listenerCallCount;
  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetEpisodeTv = MockGetEpisodeTv();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();

    provider = TvDetailNotifier(
        getTvDetail: mockGetTvDetail,
        getTvRecommendations: mockGetTvRecommendations,
        getEpisodeTv: mockGetEpisodeTv,
        getWatchListStatus: mockGetWatchListStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });
  const tId = 1;
  const tSeasonNumber = 1;
  const tIdSeason = 1;
  final tTvDetail = testTvDetail;
  final tTvList = [testTv];
  final tEpisode = testEpisode;
  final tEpisodes = [tEpisode];
  final Map<int, List<Episode>> tSeason = {
    1: <Episode>[tEpisode]
  };

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(tTvDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvList));
    when(mockGetEpisodeTv.execute(tId, tIdSeason))
        .thenAnswer((_) async =>Right(tEpisodes));
  }

  group('fetchTvSeriesDetail', () {

    test('should get data from the usecase', () async {
      _arrangeUsecase();
      //
      await provider.fetchTvSeriesDetail(tId);

      verify(mockGetTvDetail.execute(tId));
      verify(mockGetTvRecommendations.execute(tId));
      verify(mockGetEpisodeTv.execute(tId, tIdSeason));
    });
    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });


    test('should change tv detail when function error', () async{
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('failed')));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('failed')));
      when(mockGetEpisodeTv.execute(tId, tIdSeason))
          .thenAnswer((_) async => Left(ServerFailure('failed')));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Error);
      expect(provider.message, "failed");
    });


  });

  group('fetchTvEpisodeBySeason', (){
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvEpisodeBySeason(tId,tIdSeason,tSeasonNumber);
      // assert
      verify(mockGetEpisodeTv.execute(tId,tIdSeason));
      expect(provider.seasons,tSeason);
    });


    test('should update episode state when data is gotten successfully', () async{
      _arrangeUsecase();

      await provider.fetchTvEpisodeBySeason(tId,tIdSeason,tSeasonNumber);

      expect(provider.seasonState, RequestState.Loaded);
      expect(provider.seasons, tSeason);
      expect(listenerCallCount, 2);

    });

    test('should return error message when data is unsuccessful', () async{
      // arrange
      when(mockGetEpisodeTv.execute(tId,tIdSeason))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvEpisodeBySeason(tId,tIdSeason,tSeasonNumber);
      // assert
      expect(provider.seasonState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });

  });

  group('watch list',(){
    test('should get the watchlist status and type Type', () async {
      // arrange
      when(mockGetWatchListStatus.execute(1,Type.TV)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save tv watchlist when function called', () async {
      // arrange
      Watch watch = testTvDetail.copyToWatch();
      when(mockSaveWatchlist.execute(watch))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchListStatus.execute(watch.refId,Type.TV))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockSaveWatchlist.execute(watch));
    });

    test('should execute remove tv watchlist when function called', () async {
      // arrange
      Watch watch = testTvDetail.copyToWatch();

      when(mockRemoveWatchlist.execute(watch))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchListStatus.execute(watch.refId,Type.TV))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveWatchlist.execute(watch));
    });

    test('should execute remove tv watchlist when function error', () async {
      // arrange
      Watch watch = testTvDetail.copyToWatch();

      when(mockRemoveWatchlist.execute(watch))
          .thenAnswer((_) async => Left(DatabaseFailure("failed remove watch list")));
      when(mockGetWatchListStatus.execute(watch.refId,Type.TV))
          .thenAnswer((_) async => true);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveWatchlist.execute(watch));
      expect(provider.watchlistMessage, 'failed remove watch list');

    });

    test('should update tv watchlist status when add watchlist success', () async {
      // arrange
      Watch watch = testTvDetail.copyToWatch();
      when(mockSaveWatchlist.execute(watch))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListStatus.execute(watch.refId,Type.TV))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockGetWatchListStatus.execute(watch.refId,Type.TV));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update movie watchlist message when add watchlist failed', () async {
      // arrange
      Watch watch = testTvDetail.copyToWatch();
      when(mockSaveWatchlist.execute(watch))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatus.execute(watch.refId,Type.TV))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });


  });

  group('watch list',(){
    test('should get the watchlist status and type Type', () async {
      // arrange
      when(mockGetWatchListStatus.execute(1,Type.TV)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save tv watchlist when function called', () async {
      // arrange
      Watch watch = testTvDetail.copyToWatch();
      when(mockSaveWatchlist.execute(watch))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchListStatus.execute(watch.refId,Type.TV))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockSaveWatchlist.execute(watch));
    });

    test('should execute remove tv watchlist when function called', () async {
      // arrange
      Watch watch = testTvDetail.copyToWatch();

      when(mockRemoveWatchlist.execute(watch))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchListStatus.execute(watch.refId,Type.TV))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveWatchlist.execute(watch));
    });

    test('should execute remove tv watchlist when function error', () async {
      // arrange
      Watch watch = testTvDetail.copyToWatch();

      when(mockRemoveWatchlist.execute(watch))
          .thenAnswer((_) async => Left(DatabaseFailure("failed remove watch list")));
      when(mockGetWatchListStatus.execute(watch.refId,Type.TV))
          .thenAnswer((_) async => true);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveWatchlist.execute(watch));
      expect(provider.watchlistMessage, 'failed remove watch list');

    });

    test('should update tv watchlist status when add watchlist success', () async {
      // arrange
      Watch watch = testTvDetail.copyToWatch();
      when(mockSaveWatchlist.execute(watch))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListStatus.execute(watch.refId,Type.TV))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockGetWatchListStatus.execute(watch.refId,Type.TV));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update movie watchlist message when add watchlist failed', () async {
      // arrange
      Watch watch = testTvDetail.copyToWatch();
      when(mockSaveWatchlist.execute(watch))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatus.execute(watch.refId,Type.TV))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });


  });
}
