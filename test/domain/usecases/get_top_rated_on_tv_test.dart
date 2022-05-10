import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_top_rated_on_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedOnTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopRatedOnTv(mockTvRepository);
  });

  test('should get list of tv from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedOnTv())
        .thenAnswer((_) async => Right(testTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvs));
  });
}
