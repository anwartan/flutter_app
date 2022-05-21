

import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/usecases/get_now_playing_on_tv.dart';
import 'package:tv/presentation/provider/on_air_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_air_tv_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingOnTv])
void main(){
  late OnAirTvNotifier provider;
  late MockGetNowPlayingOnTv mockGetNowPlayingOnTv;
  late int listenerCallCount;
  setUp((){
    listenerCallCount = 0;
    mockGetNowPlayingOnTv = MockGetNowPlayingOnTv();
    provider = OnAirTvNotifier(mockGetNowPlayingOnTv)
      ..addListener(() {
        listenerCallCount += 1;
      });

  });

  final tTvList = <Tv>[testTv];


  group('get on air tv',(){
    test('should change state to loading when usecase is called', () async{
      when(mockGetNowPlayingOnTv.execute())
          .thenAnswer((_) async => Right(tTvList));

      provider.fetchOnAirOnTv();

      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);

    });

    test('should change search result data when data is gotten successfully',() async {
      when(mockGetNowPlayingOnTv.execute())
          .thenAnswer((_) async => Right(tTvList));

      await provider.fetchOnAirOnTv();

      expect(provider.state, RequestState.Loaded);
      expect(provider.tv, tTvList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingOnTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnAirOnTv();
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });


}