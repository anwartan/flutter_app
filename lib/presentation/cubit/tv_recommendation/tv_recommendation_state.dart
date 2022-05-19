
import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class TvRecommendationState extends Equatable{

}

class TvRecommendationLoading extends TvRecommendationState{
  @override
  List<Object?> get props => [];
}

class TvRecommendationInitialState extends TvRecommendationState{
  @override
  List<Object?> get props => [];
}


class TvRecommendationError extends TvRecommendationState{
  final String message;

  TvRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvRecommendationLoaded extends TvRecommendationState{
  final List<Tv> listTv;

  TvRecommendationLoaded(this.listTv);
  @override
  List<Object?> get props => [listTv];
}



