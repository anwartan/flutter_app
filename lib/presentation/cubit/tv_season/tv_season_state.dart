import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

abstract class TvSeasonState extends Equatable {}

class TvSeasonLoading extends TvSeasonState {
  @override
  List<Object?> get props => [];
}

class TvSeasonInitialState extends TvSeasonState {
  @override
  List<Object?> get props => [];
}

class TvSeasonLoaded extends TvSeasonState {
  final Map<int, List<Episode>> seasons = Map();

  TvSeasonLoaded(int idSeason,List<Episode> episodes){
    seasons[idSeason] = episodes;
  }

  @override
  List<Object?> get props => [seasons];
}

class TvSeasonError extends TvSeasonState {
  final String message;

  TvSeasonError(this.message);

  @override
  List<Object?> get props => [message];
}
