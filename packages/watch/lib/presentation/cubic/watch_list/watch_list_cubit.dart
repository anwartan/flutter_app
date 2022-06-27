import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch/domain/get_watchlist.dart';
import 'package:watch/presentation/cubic/watch_list/watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState>{
  final GetWatchlist getWatchlist;

  WatchListCubit(this.getWatchlist) : super(WatchListInitialState());

  Future<void> fetchWatchlist() async {
    emit(WatchListLoading());
    final result = await getWatchlist.execute();
    result.fold(
          (failure) {
        emit(WatchListError(failure.message));
      },
          (watchData) {
        emit(WatchListLoaded(watchData.map((e) => e).toList()));
      },
    );
  }
}