import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/cubit/now_playing_movie/now_playing_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingMovieCubit extends Cubit<NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieCubit(this.getNowPlayingMovies)
      : super(NowPlayingMovieInitialState());

  Future<void> fetchNowPlayingMovies() async {
    emit(NowPlayingMovieLoading());

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        emit(NowPlayingMovieError(failure.message));
      },
      (moviesData) {
        emit(NowPlayingMovieLoaded(moviesData));
      },
    );
  }
}
