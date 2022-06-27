import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/foundation.dart';
import 'package:tv/domain/usecases/get_now_playing_on_tv.dart';

class OnAirTvNotifier extends ChangeNotifier {
  final GetNowPlayingOnTv getNowPlayingOnTv;

  OnAirTvNotifier(this.getNowPlayingOnTv);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Tv> _tv = [];

  List<Tv> get tv => _tv;

  String _message = '';

  String get message => _message;

  Future<void> fetchOnAirOnTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingOnTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _tv = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
