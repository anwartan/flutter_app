import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class TopRatedMovieState extends Equatable {}

class TopRatedMovieLoading extends TopRatedMovieState {
  @override
  List<Object?> get props => [];
}

class TopRatedMovieLoaded extends TopRatedMovieState {
  final List<Movie> movies;

  TopRatedMovieLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class TopRatedMovieError extends TopRatedMovieState {
  final String message;

  TopRatedMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class TopRatedMovieInitialState extends TopRatedMovieState {
  TopRatedMovieInitialState();

  @override
  List<Object?> get props => [];
}
