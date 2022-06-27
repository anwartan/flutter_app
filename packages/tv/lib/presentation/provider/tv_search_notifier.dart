import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/foundation.dart';
import 'package:search/domain/usecases/search_on_tv.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchOnTv searchOnTv;

  TvSearchNotifier({required this.searchOnTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _searchResult = [];
  List<Tv> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchOnTv.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
