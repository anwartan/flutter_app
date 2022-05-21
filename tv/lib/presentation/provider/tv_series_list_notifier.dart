import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/cupertino.dart';
import 'package:tv/domain/usecases/get_now_playing_on_tv.dart';

import '../../domain/usecases/get_popular_on_tv.dart';
import '../../domain/usecases/get_top_rated_on_tv.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  final GetNowPlayingOnTv getNowPlayingOnTv;
  final GetPopularOnTv getPopularOnTv;
  final GetTopRatedOnTv getTopRatedOnTv;
  TvSeriesListNotifier(
      {required this.getNowPlayingOnTv, required this.getPopularOnTv,required this.getTopRatedOnTv});

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

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  List<Tv> _topRated = [];
  List<Tv> get topRated => _topRated;

  String _topRatedMessage = '';
  String get topRatedMessage => _topRatedMessage;

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

  Future<void> fetchTopRatedOnTv() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();
    final result = await getTopRatedOnTv.execute();
    result.fold(
      (failure) {
        _topRatedMessage = failure.message;
        _topRatedState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _topRated = data;
        _topRatedState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
