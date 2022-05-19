import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/datasources/watch_local_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/data/repositories/watch_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/repositories/watch_repository.dart';
import 'package:ditonton/domain/usecases/get_episode_tv.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_on_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_on_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_on_tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendation.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_on_tv.dart';
import 'package:ditonton/presentation/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/movie_recommendation/movie_recommendation_cubit.dart';
import 'package:ditonton/presentation/cubit/now_playing_movie/now_playing_movie_cubit.dart';
import 'package:ditonton/presentation/cubit/on_air_tv/on_air_tv_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_movie/popular_movie_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_tv/popular_tv_cubit.dart';
import 'package:ditonton/presentation/cubit/search/search_cubit.dart';
import 'package:ditonton/presentation/cubit/top_rated_movie/top_rated_movie_cubit.dart';
import 'package:ditonton/presentation/cubit/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_detail/tv_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_recommendation/tv_recommendation_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_season/tv_season_cubit.dart';
import 'package:ditonton/presentation/cubit/watch/watch_cubit.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/on_air_tv_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tv_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  //bloC
  locator.registerFactory(() => MovieDetailCubit(getMovieDetail: locator()));

  locator.registerFactory(
      () => MovieRecommendationCubit(getMovieRecommendations: locator()));

  locator.registerFactory(
      () => WatchCubit(locator(), locator(), locator(), locator()));

  locator.registerFactory(() => PopularMovieCubit(locator()));

  locator.registerFactory(() => TopRatedMovieCubit(locator()));

  locator.registerFactory(() => NowPlayingMovieCubit(locator()));

  locator.registerFactory(() => SearchCubit(locator(), locator()));

  locator.registerFactory(() => OnAirTvCubit(locator()));

  locator.registerFactory(() => PopularTvCubit(locator()));
  locator.registerFactory(() => TopRatedTvCubit(locator()));
  locator.registerFactory(() => TvDetailCubit(locator()));

  locator.registerFactory(() => TvSeasonCubit(locator()));
  locator.registerFactory(() => TvRecommendationCubit(locator()));

  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlist: locator(),
    ),
  );
  locator.registerFactory(() => TvSeriesListNotifier(
      getNowPlayingOnTv: locator(),
      getPopularOnTv: locator(),
      getTopRatedOnTv: locator()));
  locator.registerFactory(() => PopularTvNotifier(locator()));
  locator.registerFactory(() => OnAirTvNotifier(locator()));
  locator.registerFactory(() => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getEpisodeTv: locator(),
      saveWatchlist: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator()));
  locator.registerFactory(() => TvSearchNotifier(searchOnTv: locator()));
  locator.registerFactory(() => TopRatedTvNotifier(getTopRatedOnTv: locator()));
  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlist(locator()));

  locator.registerLazySingleton(() => GetNowPlayingOnTv(locator()));
  locator.registerLazySingleton(() => GetPopularOnTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetEpisodeTv(locator()));
  locator.registerLazySingleton(() => SearchOnTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedOnTv(locator()));
  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
      () => TvRepositoryImpl(tvRemoteDataSource: locator()));
  locator.registerLazySingleton<WatchRepository>(
      () => WatchRepositoryImpl(localDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  // locator.registerLazySingleton<MovieLocalDataSource>(
  //     () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<WatchLocalDataSource>(
      () => WatchLocalDataSourceImpl(databaseHelper: locator()));
  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton<CustomIOClient>(() => CustomIOClient());
}
