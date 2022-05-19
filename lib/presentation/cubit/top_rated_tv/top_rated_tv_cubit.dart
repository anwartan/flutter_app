import 'package:ditonton/domain/usecases/get_top_rated_on_tv.dart';
import 'package:ditonton/presentation/cubit/top_rated_tv/top_rated_tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvCubit extends Cubit<TopRatedTvState> {
  final GetTopRatedOnTv getTopRatedOnTv;
  TopRatedTvCubit(this.getTopRatedOnTv) : super(TopRatedTvInitialState());

  Future<void> fetchTopRatedTv() async {
    emit(TopRatedTvLoading());
    final result = await getTopRatedOnTv.execute();

    result.fold(
      (failure) {
        emit(TopRatedTvError(failure.message));
      },
      (data) {
        emit(TopRatedTvLoaded(data));
      },
    );
  }
}
