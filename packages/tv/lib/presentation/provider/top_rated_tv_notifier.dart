import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/foundation.dart';
import 'package:tv/domain/usecases/get_top_rated_on_tv.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedOnTv getTopRatedOnTv;

  TopRatedTvNotifier({required this.getTopRatedOnTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedOnTv.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (moviesData) {
        _tv = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
