import 'package:ditonton/common/enum.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/cubit/watch/watch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchCubit extends Cubit<WatchState> {
  final GetWatchlist getWatchlist;
  final SaveWatchlist saveWatchlist;
  final GetWatchListStatus getWatchListStatus;
  final RemoveWatchlist removeWatchlist;

  WatchCubit(this.getWatchlist, this.saveWatchlist, this.getWatchListStatus,
      this.removeWatchlist)
      : super(WatchInitialState());

  Future<void> fetchWatchlist() async {
    emit(WatchLoading());
    final result = await getWatchlist.execute();
    result.fold(
      (failure) {
        emit(WatchError(failure.message));
      },
      (watchData) {
        emit(WatchListLoaded(watchData.map((e) => e).toList()));
      },
    );
  }



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
