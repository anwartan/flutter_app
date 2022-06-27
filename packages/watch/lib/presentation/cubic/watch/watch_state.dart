import 'package:core/domain/entities/watch.dart';
import 'package:equatable/equatable.dart';

abstract class WatchState extends Equatable{

}
class WatchInitialState extends WatchState{
  @override
  List<Object?> get props => [];

}
class WatchLoading extends WatchState{
  @override
  List<Object?> get props => [];

}

class WatchError extends WatchState{
  final String message;

  WatchError(this.message);

  @override
  List<Object?> get props => [message];

}


class WatchListLoaded extends WatchState{
  final List<Watch> listWatch;

  WatchListLoaded(this.listWatch);

  @override
  List<Object?> get props =>[listWatch];

}

class WatchMessage extends WatchState{
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final String message;

  WatchMessage(this.message);

  @override
  List<Object?> get props =>[message];

}

class WatchCheckAdded extends WatchState{
  final bool isAdded;

  WatchCheckAdded(this.isAdded);

  @override
  List<Object?> get props => [isAdded];

}