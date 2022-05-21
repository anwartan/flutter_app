import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/watch_table.dart';


abstract class WatchLocalDataSource {
  Future<String> insertWatchlist(WatchTable watch);
  Future<String> removeWatchlist(WatchTable watch);
  Future<WatchTable?> getWatchByIdAndType(int refId, Type type);
  Future<List<WatchTable>> getWatchlist();
}

class WatchLocalDataSourceImpl implements WatchLocalDataSource {
  final DatabaseHelper databaseHelper;

  WatchLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchTable watch) async {
    try {
      await databaseHelper.insertWatchlist(watch);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchTable watch) async {
    try {
      await databaseHelper.removeWatchlist(watch);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchTable?> getWatchByIdAndType(int refId, Type type) async {
    final result = await databaseHelper.getWatchByRefIdAndType(refId, type);
    if (result != null) {
      return WatchTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchTable>> getWatchlist() async {
    final result = await databaseHelper.getWatchlist();
    return result.map((data) => WatchTable.fromMap(data)).toList();
  }
}
