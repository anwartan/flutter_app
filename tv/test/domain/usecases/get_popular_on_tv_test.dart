import 'package:dartz/dartz.dart';
import 'package:tv/domain/usecases/get_popular_on_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularOnTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularOnTv(mockTvRepository);
  });


  test('should get popular tv series from the repository', () async {
    // arrange
    when(mockTvRepository.getPopularOnTv())
        .thenAnswer((_) async => Right(testTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvs));
  });
}