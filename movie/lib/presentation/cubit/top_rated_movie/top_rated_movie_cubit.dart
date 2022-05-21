import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/get_top_rated_movies.dart';

import 'top_rated_movie_state.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieCubit(this.getTopRatedMovies)
      : super(TopRatedMovieInitialState());

  Future<void> fetchTopRatedMovies() async {
    emit(TopRatedMovieLoading());

    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        emit(TopRatedMovieError(failure.message));
      },
      (moviesData) {
        emit(TopRatedMovieLoaded(moviesData));
      },
    );
  }
}
