import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatus usecase;
  late MockWatchRepository mockWatchRepository;

  setUp(() {
    mockWatchRepository = MockWatchRepository();
    usecase = GetWatchListStatus(mockWatchRepository);
  });

  test('should get watchlist status and type Movie from repository', () async {
    // arrange
    when(mockWatchRepository.isAddedToWatchlist(1,Type.MOVIE))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1,Type.MOVIE);
    // assert
    expect(result, true);
  });
  test('should get watchlist status and type Tv from repository', () async {
    // arrange
    when(mockWatchRepository.isAddedToWatchlist(2,Type.TV))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(2,Type.TV);
    // assert
    expect(result, true);
  });
}
