import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class PopularMovieState extends Equatable{

}

class PopularMovieLoading extends PopularMovieState{
  @override
  List<Object?> get props => [];

}

class PopularMovieError extends PopularMovieState{
  final String message;

  PopularMovieError(this.message);

  @override
  List<Object?> get props =>[message];

}
class PopularMovieInitialState extends PopularMovieState{

  PopularMovieInitialState();

  @override
  List<Object?> get props =>[];

}
class PopularMovieLoaded extends PopularMovieState{
  final List<Movie> movies;

  PopularMovieLoaded(this.movies);

  @override
  List<Object?> get props =>[movies];

}