import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailState extends Equatable {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';


  const MovieDetailState();

  @override
  List<Object> get props => [];
}
class MovieDetailEmpty extends MovieDetailState  {}
class MovieDetailLoading extends MovieDetailState {}
class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;
  const MovieDetailHasData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}