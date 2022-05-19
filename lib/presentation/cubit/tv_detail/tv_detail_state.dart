
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvDetailState extends Equatable{

}
class TvDetailInitialState extends TvDetailState{
  @override
  List<Object?> get props => [];

}
class TvDetailLoading extends TvDetailState{
  @override
  List<Object?> get props => [];

}

class TvDetailError extends TvDetailState{
  final String message;

  TvDetailError(this.message);

  @override
  List<Object?> get props => [message];

}

class TvDetailLoaded extends TvDetailState{
  final TvDetail tvDetail;

  TvDetailLoaded(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];

}


