import 'package:core/domain/entities/watch.dart';
import 'package:equatable/equatable.dart';

abstract class WatchListState extends Equatable{

}
class WatchListInitialState extends WatchListState{
  @override
  List<Object?> get props => [];

}
class WatchListLoading extends WatchListState{
  @override
  List<Object?> get props => [];

}

class WatchListError extends WatchListState{
  final String message;

  WatchListError(this.message);

  @override
  List<Object?> get props => [message];

}


class WatchListLoaded extends WatchListState{
  final List<Watch> listWatch;

  WatchListLoaded(this.listWatch);

  @override
  List<Object?> get props =>[listWatch];

}