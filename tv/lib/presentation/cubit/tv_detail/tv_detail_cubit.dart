import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/presentation/cubit/tv_detail/tv_detail_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  final GetTvDetail getTvDetail;
  TvDetailCubit(this.getTvDetail)
      : super(TvDetailInitialState());

  Future<void> fetchTvSeriesDetail(int id) async {
    emit(TvDetailLoading());
    final result = await getTvDetail.execute(id);

    result.fold(
      (failure) {
        emit(TvDetailError(failure.message));
      },
      (data) async {
        emit(TvDetailLoaded(data));

      },
    );
  }


}
