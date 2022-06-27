import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class NowPlayingMovieState extends Equatable {}

class NowPlayingMovieLoaded extends NowPlayingMovieState {
  final List<Movie> movies;

  NowPlayingMovieLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}

class NowPlayingMovieLoading extends NowPlayingMovieState {
  @override
  List<Object?> get props => [];
}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;

  NowPlayingMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class NowPlayingMovieInitialState extends NowPlayingMovieState {

  NowPlayingMovieInitialState();

  @override
  List<Object?> get props => [];
}
