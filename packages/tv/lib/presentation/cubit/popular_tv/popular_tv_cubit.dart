import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/get_popular_on_tv.dart';
import 'package:tv/presentation/cubit/popular_tv/popular_tv_state.dart';

class PopularTvCubit extends Cubit<PopularTvState> {
  final GetPopularOnTv getPopularOnTv;

  PopularTvCubit(this.getPopularOnTv) : super(PopularTvInitialState());
  Future<void> fetchPopularOnTv() async {
    emit(PopularTvLoading());

    final result = await getPopularOnTv.execute();

    result.fold(
      (failure) {
        emit(PopularTvError(failure.message));
      },
      (data) {
        emit(PopularTvLoaded(data));
      },
    );
  }
}
