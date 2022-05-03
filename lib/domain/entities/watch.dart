import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:equatable/equatable.dart';

class Watch extends Equatable {
  late int? id;
  final int refId;
  final String? title;
  final String? posterPath;
  final String? overview;
  final Type type;

  Watch(
      {required this.refId,
      required this.title,
      required this.posterPath,
      required this.overview,
      required this.type,
      this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [refId, title, posterPath, overview, type];

  Watch.watchlist(
      {required this.refId,
      required this.overview,
      required this.posterPath,
      required this.title,
      required this.type});

  Tv copyToTv() => Tv.watchlist(
      id: refId, overview: overview, posterPath: posterPath, name: title);
  Movie copyToMovie() => Movie.watchlist(
      id: refId, overview: overview, posterPath: posterPath, title: title);
}
