import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/get_episode_tv.dart';

import 'tv_season_state.dart';

class TvSeasonCubit extends Cubit<TvSeasonState> {
  final GetEpisodeTv getEpisodeTv;
  TvSeasonCubit(this.getEpisodeTv) : super(TvSeasonInitialState());

  Future<void> fetchTvEpisodeBySeason(
      int idTv, int idSeason, int seasonNumber) async {
    final episodeResult = await getEpisodeTv.execute(idTv, seasonNumber);
    emit(TvSeasonLoading());
    episodeResult.fold(
      (failure) {
        emit(TvSeasonError(failure.message));
      },
      (data) {
        emit(TvSeasonLoaded(idSeason,data));
      },
    );
  }
}
