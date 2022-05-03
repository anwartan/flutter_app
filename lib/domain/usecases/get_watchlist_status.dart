import 'package:ditonton/domain/repositories/watch_repository.dart';
import 'package:ditonton/presentation/pages/search_page.dart';

class GetWatchListStatus {
  final WatchRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id, Type type) async {
    return repository.isAddedToWatchlist(id, type);
  }
}
