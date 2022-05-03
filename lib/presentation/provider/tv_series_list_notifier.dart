import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_on_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_on_tv.dart';
import 'package:flutter/cupertino.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  final GetNowPlayingOnTv getNowPlayingOnTv;
  final GetPopularOnTv getPopularOnTv;
  TvSeriesListNotifier(
      {required this.getNowPlayingOnTv, required this.getPopularOnTv});

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  List<Tv> _onAir = [];
  List<Tv> get onAir => _onAir;

  String _onAirMessage = '';
  String get onAirMessage => _onAirMessage;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  List<Tv> _popular = [];
  List<Tv> get popular => _popular;

  String _popularMessage = '';
  String get popularMessage => _popularMessage;

  Future<void> fetchNowPlayingOnTv() async {
    _onAirState = RequestState.Loading;
    notifyListeners();
    final result = await getNowPlayingOnTv.execute();
    result.fold(
      (failure) {
        _onAirMessage = failure.message;
        _onAirState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _onAir = data;
        _onAirState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularOnTv() async {
    _popularState = RequestState.Loading;
    notifyListeners();
    final result = await getPopularOnTv.execute();
    result.fold(
      (failure) {
        _popularMessage = failure.message;
        _popularState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _popular = data;
        _popularState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
