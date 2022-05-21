import 'package:core/core.dart';
import 'package:core/domain/repositories/watch_repository.dart';

class GetWatchListStatus {
  final WatchRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id, Type type) async {
    return repository.isAddedToWatchlist(id, type);
  }
}
