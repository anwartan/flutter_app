import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_on_tv.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchOnTv])
void main(){
  late TvSearchNotifier provider;
  late MockSearchOnTv mockSearchOnTv;

  late int listenerCallCount;
  setUp((){
    listenerCallCount = 0;
    mockSearchOnTv = MockSearchOnTv();
    provider = TvSearchNotifier(searchOnTv: mockSearchOnTv)
      ..addListener(() {
        listenerCallCount += 1;
      });

  });

  final tTvList = <Tv>[testTv];
  final tQuery = 'spiderman';

  group('search on tv', (){
    test('should change state to loading when usecase is called', () async{
      when(mockSearchOnTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));

      provider.fetchTvSearch(tQuery);

      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);

    });

    test('should change search result data when data is gotten successfully', () async{
      when(mockSearchOnTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));

      await provider.fetchTvSearch(tQuery);

      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvList);
      expect(listenerCallCount, 2);

    });

    test('should return error when data is unsuccessful', () async{
      // arrange
      when(mockSearchOnTv.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

}