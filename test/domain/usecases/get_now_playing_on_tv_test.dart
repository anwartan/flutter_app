import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_now_playing_on_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingOnTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetNowPlayingOnTv(mockTvRepository);
  });


  test('should get tv series now playing from the repository', () async {
    // arrange
    when(mockTvRepository.getNowPlayingOnTv())
        .thenAnswer((_) async => Right(testTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvs));
  });
}