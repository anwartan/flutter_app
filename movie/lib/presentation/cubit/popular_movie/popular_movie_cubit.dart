import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/get_popular_movies.dart';
import 'package:movie/presentation/cubit/popular_movie/popular_movie_state.dart';

class PopularMovieCubit extends Cubit<PopularMovieState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieCubit(this.getPopularMovies) : super(PopularMovieInitialState());

  Future<void> fetchPopularMovies() async {
    emit(PopularMovieLoading());

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(PopularMovieError(failure.message));
      },
      (moviesData) {
        emit(PopularMovieLoaded(moviesData));
      },
    );
  }
}
