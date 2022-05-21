import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class PopularTvState extends Equatable {}

class PopularTvLoading extends PopularTvState {
  @override
  List<Object?> get props => [];
}

class PopularTvLoaded extends PopularTvState {
  final List<Tv> listTv;

  PopularTvLoaded(this.listTv);

  @override
  List<Object?> get props => [listTv];
}

class PopularTvError extends PopularTvState {
  final String message;

  PopularTvError(this.message);

  @override
  List<Object?> get props => [message];
}

class PopularTvInitialState extends PopularTvState {
  PopularTvInitialState();

  @override
  List<Object?> get props => [];
}
