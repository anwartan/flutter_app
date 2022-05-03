import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_episode_tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendation.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter/foundation.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetEpisodeTv getEpisodeTv;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  TvDetailNotifier(
      {required this.getTvDetail,
      required this.getTvRecommendations,
      required this.getEpisodeTv,
      required this.getWatchListStatus,
      required this.saveWatchlist,
      required this.removeWatchlist});

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  List<Tv> _tvRecommendations = [];
  List<Tv> get tvRecommendations => _tvRecommendations;
  RequestState _seasonState = RequestState.Empty;
  RequestState get seasonState => _seasonState;
  Map<int, List<Episode>> _Seasons = Map();
  Map<int, List<Episode>> get seasons => _Seasons;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) async {
        _recommendationState = RequestState.Loading;
        _tvDetail = data;
        notifyListeners();
        if (data.seasons.length > 0) {
          await fetchTvEpisodeBySeason(
              data.id, data.seasons[0].id, data.seasons[0].seasonNumber);
        }
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (data) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = data;
          },
        );
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvEpisodeBySeason(
      int idTv, int idSeason, int seasonNumber) async {
    final episodeResult = await getEpisodeTv.execute(idTv, seasonNumber);
    _seasonState = RequestState.Loading;
    notifyListeners();
    episodeResult.fold(
      (failure) {
        _seasonState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _Seasons[idSeason] = data;
        _seasonState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail tvDetail) async {
    final result = await saveWatchlist.execute(tvDetail.copyToWatch());

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvDetail.id);
  }

  Future<void> removeFromWatchlist(TvDetail tvDetail) async {
    final result = await removeWatchlist.execute(tvDetail.copyToWatch());

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvDetail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id, Type.TV);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
