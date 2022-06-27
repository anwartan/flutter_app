import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {}

class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchMovieLoaded extends SearchState {
  final List<Movie> movies;

  SearchMovieLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}

class SearchTvLoaded extends SearchState {
  final List<Tv> tv;

  SearchTvLoaded(this.tv);
  @override
  List<Object?> get props => [tv];
}
