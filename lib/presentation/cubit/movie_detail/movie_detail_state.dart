import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailState extends Equatable {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';


  MovieDetailState();

  @override
  List<Object> get props => [];
}
class MovieDetailEmpty extends MovieDetailState  {}
class MovieDetailLoading extends MovieDetailState {}
class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;
  MovieDetailHasData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}