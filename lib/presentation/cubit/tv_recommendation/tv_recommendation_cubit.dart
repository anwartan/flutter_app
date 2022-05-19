import 'package:ditonton/domain/usecases/get_tv_recommendation.dart';
import 'package:ditonton/presentation/cubit/tv_recommendation/tv_recommendation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
