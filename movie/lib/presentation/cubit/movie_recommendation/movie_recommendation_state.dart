import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieRecommendationState extends Equatable {

}

class MovieRecommendationInitialState extends MovieRecommendationState  {
  @override
  List<Object?> get props => [];
}

class MovieRecommendationLoading extends MovieRecommendationState {
  @override
  List<Object?> get props => [];

}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;

  MovieRecommendationError(this.message);

  @override
  List<Object?> get props => [message];

}

class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<Movie> recommendations;

  MovieRecommendationLoaded(this.recommendations);

  @override
  List<Object?> get props => [recommendations];

}
