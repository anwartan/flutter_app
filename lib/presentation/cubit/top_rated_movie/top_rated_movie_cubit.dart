import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/cubit/top_rated_movie/top_rated_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
