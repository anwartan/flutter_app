
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class OnAirTvState extends Equatable{

}

class OnAirTvLoading extends OnAirTvState{
  @override
  List<Object?> get props => [];

}
class OnAirTvInitialState extends OnAirTvState{
  @override
  List<Object?> get props => [];

}

class OnAirTvLoaded extends OnAirTvState{
  final List<Tv> listTv;

  OnAirTvLoaded(this.listTv);
  @override
  List<Object?> get props => [listTv];

}

class OnAirTvError extends OnAirTvState{
  final String message;

  OnAirTvError(this.message);

  @override
  List<Object?> get props => [message];

}