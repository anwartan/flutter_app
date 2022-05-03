import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockWatchRepository mockWatchRepository;
  setUp(() {
    mockWatchRepository = MockWatchRepository();
    usecase = RemoveWatchlist(mockWatchRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockWatchRepository.removeWatchlist(testWatch))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testWatch);
    // assert
    verify(mockWatchRepository.removeWatchlist(testWatch));
    expect(result, Right('Removed from watchlist'));
  });
}
