import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/search_on_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchOnTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchOnTv(mockTvRepository);
  });

  final tQuery = 'Spiderman';

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvRepository.searchOnTv(tQuery))
        .thenAnswer((_) async => Right(testTvs));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(testTvs));
  });
}
