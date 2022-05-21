import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_episode_tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';



void main() {
  late GetEpisodeTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetEpisodeTv(mockTvRepository);
  });

  const tId = 1;
  const tIdSeason = 1;
  test('should get list episode tv from the repository', () async {
    // arrange

    when(mockTvRepository.getTvEpisodeBySeason(tId,tIdSeason))
        .thenAnswer((_) async => Right(testEpisodes));
    // act
    final result = await usecase.execute(tId,tIdSeason);
    // assert
    expect(result, Right(testEpisodes));
  });
}