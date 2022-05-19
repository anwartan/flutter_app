import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/watch_table.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/watch.dart';
import 'package:ditonton/common/enum.dart';

final date = DateTime.parse("2005-05-05");
final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testWatch = Watch(
    refId: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    type: Type.MOVIE);
final testWatchTv = Watch(
    refId: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    type: Type.TV);
final testWatchList = [testWatch];

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testEpisode = Episode(
    airDate: date,
    episodeNumber: 1,
    id: 1,
    name: "name",
    overview: "overview",
    productionCode: "productionCode",
    seasonNumber: 1,
    stillPath: "stillPath",
    voteAverage: 1,
    voteCount: 1);
final testEpisodes = [testEpisode];
final testGenre = Genre(id: 1, name: "name");
final testSeason = Season(
    airDate: date,
    episodeCount: 1,
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1);

final testTvDetail = TvDetail(
    backdropPath: "backdropPath",
    genres: [testGenre],
    id: 1,
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalName: "originalName",
    overview: "overview",
    posterPath: "posterPath",
    seasons: [testSeason],
    voteAverage: 1.0);

final testTv = Tv(
    posterPath: "posterPath",
    popularity: 20,
    id: 1,
    backdropPath: "backdropPath",
    voteAverage: 1,
    overview: "overview",
    firstAirDate: date,
    originCountry: ["originCountry"],
    genreIds: [1],
    originalLanguage: "originalLanguage",
    voteCount: 1,
    name: "name",
    originalName: "originalName");
final testTvs = [testTv];
final testTvDetailModel = TvDetailModel(
    backdropPath: "backdropPath",
    genres: [GenreModel(id: 1, name: "name")],
    id: 1,
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalName: "originalName",
    overview: "overview",
    posterPath: "posterPath",
    seasons: [
      SeasonModel(
          airDate: date,
          episodeCount: 1,
          id: 1,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 1)
    ],
    voteAverage: 1);
final testEpisodeModel = EpisodeModel(
    airDate: date,
    episodeNumber: 1,
    id: 1,
    name: "name",
    overview: "overview",
    productionCode: "productionCode",
    seasonNumber: 1,
    stillPath: "stillPath",
    voteAverage: 1,
    voteCount: 1);
final testTvModel = TvModel(
    posterPath: 'posterPath',
    popularity: 20,
    id: 1,
    backdropPath: "backdropPath",
    voteAverage: 1,
    overview: "overview",
    firstAirDate: date,
    originCountry: ["originCountry"],
    genreIds: [1],
    originalLanguage: "originalLanguage",
    voteCount: 1,
    name: "name",
    originalName: "originalName");
final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchTable = WatchTable(
    id: 1,
    refId: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    type: Type.MOVIE);

final testWatchMap = {
  'id': 1,
  'refId': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': 0
};

final testWatchTableWithoutId = WatchTable(
    id: null,
    refId: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    type: Type.MOVIE);
final testWatchMapWithoutId = {
  'id': null,
  'refId': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': 0
};
