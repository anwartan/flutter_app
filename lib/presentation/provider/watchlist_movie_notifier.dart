import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/watch.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:flutter/foundation.dart';

class WatchlistMovieNotifier extends ChangeNotifier {

  var _watchlist = <Watch>[];
  List<Watch> get watchlist => _watchlist;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  final GetWatchlist getWatchlist;

  WatchlistMovieNotifier({required this.getWatchlist});

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();
    final result = await getWatchlist.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (watchData) {
        _watchlistState = RequestState.Loaded;
        _watchlist = watchData.map((e) => e).toList();
        notifyListeners();
      },
    );
  }
}
