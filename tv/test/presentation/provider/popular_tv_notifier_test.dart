import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_popular_on_tv.dart';
import 'package:tv/presentation/provider/popular_tv_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_list_notifier_test.mocks.dart';


@GenerateMocks([GetPopularOnTv])
void main() {
  late MockGetPopularOnTv mockGetPopularOnTv;
  late PopularTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularOnTv = MockGetPopularOnTv();
    notifier = PopularTvNotifier(mockGetPopularOnTv)
      ..addListener(() {
        listenerCallCount++;
      });
  });


  final tTvList = <Tv>[testTv];
  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularOnTv.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchPopularOnTv();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularOnTv.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchPopularOnTv();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tv, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularOnTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularOnTv();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
