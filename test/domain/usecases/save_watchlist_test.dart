import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockWatchRepository mockWatchRepository;
  setUp(() {
    mockWatchRepository = MockWatchRepository();
    usecase = SaveWatchlist(mockWatchRepository);
  });

  test('should save watch to the repository', () async {
    // arrange
    when(mockWatchRepository.saveWatchlist(testWatch))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testWatch);
    // assert
    verify(mockWatchRepository.saveWatchlist(testWatch));
    expect(result, Right('Added to Watchlist'));
  });
}
