import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watch/domain/save_watchlist.dart';

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
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testWatch);
    // assert
    verify(mockWatchRepository.saveWatchlist(testWatch));
    expect(result, const Right('Added to Watchlist'));
  });
}
