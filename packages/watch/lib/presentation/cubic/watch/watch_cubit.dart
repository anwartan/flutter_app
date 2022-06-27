import 'package:core/core.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch/domain/get_watchlist_status.dart';
import 'package:watch/domain/remove_watchlist.dart';
import 'package:watch/domain/save_watchlist.dart';

import 'watch_state.dart';

class WatchCubit extends Cubit<WatchState> {

  final SaveWatchlist saveWatchlist;
  final GetWatchListStatus getWatchListStatus;
  final RemoveWatchlist removeWatchlist;

  WatchCubit( this.saveWatchlist, this.getWatchListStatus,
      this.removeWatchlist)
      : super(WatchInitialState());


  Future<void> addWatchlistMovie(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie.copyToWatch());

    await result.fold(
      (failure) async {
        emit(WatchError(failure.message));
      },
      (successMessage) async {
        emit(WatchMessage(successMessage));
      },
    );
  }
  Future<void> addWatchlistTv(TvDetail tvDetail) async {
    final result = await saveWatchlist.execute(tvDetail.copyToWatch());

    await result.fold(
          (failure) async {
        emit(WatchError(failure.message));
      },
          (successMessage) async {
        emit(WatchMessage(successMessage));
      },
    );
  }

  Future<void> removeWatchlistMovie(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie.copyToWatch());

    await result.fold(
          (failure) async {
        emit(WatchError(failure.message));
      },
          (successMessage) async {
        emit(WatchMessage(successMessage));
      },
    );
  }
  Future<void> removeWatchlistTv(TvDetail tvDetail) async {
    final result = await removeWatchlist.execute(tvDetail.copyToWatch());

    await result.fold(
          (failure) async {
        emit(WatchError(failure.message));
      },
          (successMessage) async {
        emit(WatchMessage(successMessage));
      },
    );
  }
  Future<void> isAddedToWatchlist(int id, Type type) async {
    final result = await getWatchListStatus.execute(id,type);
    emit(WatchCheckAdded(result));
  }
}
