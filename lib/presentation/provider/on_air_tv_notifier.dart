import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_on_tv.dart';
import 'package:flutter/foundation.dart';

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
