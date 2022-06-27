import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/get_tv_recommendation.dart';
import 'package:tv/presentation/cubit/tv_recommendation/tv_recommendation_state.dart';

class TvRecommendationCubit extends Cubit<TvRecommendationState> {
  final GetTvRecommendations getTvRecommendations;

  TvRecommendationCubit(this.getTvRecommendations)
      : super(TvRecommendationInitialState());

  Future<void> fetchTvRecommendation(int id) async {
    emit(TvRecommendationLoading());
    final recommendationResult = await getTvRecommendations.execute(id);

    recommendationResult.fold(
      (failure) {
        emit(TvRecommendationError(failure.message));
      },
      (data) {
        emit(TvRecommendationLoaded(data));
      },
    );
  }
}
