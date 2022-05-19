import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class TopRatedTvState extends Equatable {}

class TopRatedTvLoading extends TopRatedTvState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvLoaded extends TopRatedTvState {
  final List<Tv> listTv;

  TopRatedTvLoaded(this.listTv);

  @override
  List<Object?> get props => [listTv];
}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  TopRatedTvError(this.message);

  @override
  List<Object?> get props => [message];
}

class TopRatedTvInitialState extends TopRatedTvState {
  TopRatedTvInitialState();

  @override
  List<Object?> get props => [];
}
