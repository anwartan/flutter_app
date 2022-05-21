import 'package:core/domain/entities/watch.dart';
import 'package:core/utils/enum.dart';

import 'package:equatable/equatable.dart';

class WatchTable extends Equatable {
  final int? id;
  final int refId;
  final String? title;
  final String? posterPath;
  final String? overview;
  final Type type;

  const WatchTable(
      {required this.refId,
      required this.title,
      required this.posterPath,
      required this.overview,
      required this.type,
      this.id});

  factory WatchTable.fromEntity(Watch watch) => WatchTable(
      refId: watch.refId,
      title: watch.title,
      posterPath: watch.posterPath,
      overview: watch.overview,
      type: watch.type);

  Map<String, dynamic> toJson() => {
        'id': id,
        'refId': refId,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'type': type.index
      };

  @override
  List<Object?> get props => [id, refId, title, posterPath, overview, type];

  factory WatchTable.fromMap(Map<String, dynamic> map) => WatchTable(
      refId: map['refId'],
      title: map['title'],
      posterPath: map['posterPath'],
      overview: map['overview'],
      type: Type.values[map['type']],
      id: map['id']);

  Watch toEntity() => Watch.watchlist(
      refId: refId,
      overview: overview,
      posterPath: posterPath,
      title: title,
      type: type,
      id: id);
}
