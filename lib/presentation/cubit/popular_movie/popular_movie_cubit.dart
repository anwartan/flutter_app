import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/cubit/popular_movie/popular_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
