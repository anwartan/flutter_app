import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/cubit/movie_recommendation/movie_recommendation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MovieRecommendationCubit extends Cubit<MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;
  MovieRecommendationCubit({required this.getMovieRecommendations})
      : super(MovieRecommendationInitialState());

  Future<void> fetchMovieRecommendations(int id) async {
    emit(MovieRecommendationLoading());
    final recommendationResult = await getMovieRecommendations.execute(id);
    recommendationResult.fold(
      (failure) {
        emit(MovieRecommendationError(failure.message));
      },
      (movies) {
        emit(MovieRecommendationLoaded(movies));
      },
    );
  }
}
