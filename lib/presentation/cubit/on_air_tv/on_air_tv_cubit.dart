
import 'package:ditonton/domain/usecases/get_now_playing_on_tv.dart';
import 'package:ditonton/presentation/cubit/on_air_tv/on_air_tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnAirTvCubit extends Cubit<OnAirTvState>{
  final GetNowPlayingOnTv getNowPlayingOnTv;


  OnAirTvCubit(this.getNowPlayingOnTv) : super(OnAirTvInitialState());

  Future<void> fetchOnAirOnTv() async {
    emit(OnAirTvLoading());
    final result = await getNowPlayingOnTv.execute();

    result.fold(
          (failure) {
            emit(OnAirTvError(failure.message));
      },
          (data) {
            emit(OnAirTvLoaded(data));
      },
    );
  }

}