import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:movie/presentation/provider/movie_search_notifier.dart';
import 'package:tv/presentation/provider/on_air_tv_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:tv/presentation/provider/popular_tv_notifier.dart';
import 'package:tv/presentation/provider/top_rated_tv_notifier.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';
import 'package:tv/presentation/provider/tv_search_notifier.dart';
import 'package:tv/presentation/provider/tv_series_list_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:movie/presentation/cubit/movie_recommendation/movie_recommendation_cubit.dart';
import 'package:movie/presentation/cubit/now_playing_movie/now_playing_movie_cubit.dart';
import 'package:movie/presentation/cubit/popular_movie/popular_movie_cubit.dart';
import 'package:movie/presentation/cubit/top_rated_movie/top_rated_movie_cubit.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/cubit/search/search_cubit.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:tv/presentation/cubit/on_air_tv/on_air_tv_cubit.dart';
import 'package:tv/presentation/cubit/popular_tv/popular_tv_cubit.dart';
import 'package:tv/presentation/cubit/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:tv/presentation/cubit/tv_detail/tv_detail_cubit.dart';
import 'package:tv/presentation/cubit/tv_recommendation/tv_recommendation_cubit.dart';
import 'package:tv/presentation/cubit/tv_season/tv_season_cubit.dart';
import 'package:tv/presentation/pages/on_air_tv_page.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/tv_series_page.dart';
import 'package:watch/presentation/cubic/watch/watch_cubit.dart';
import 'package:watch/presentation/pages/watchlist_movies_page.dart';
import 'package:watch/presentation/provider/watchlist_movie_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
            create: (_) => di.locator<TvSeriesListNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<PopularTvNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<OnAirTvNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<TvDetailNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<TvSearchNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<TopRatedTvNotifier>()),
        BlocProvider(create: (_) => di.locator<MovieDetailCubit>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationCubit>()),
        BlocProvider(create: (_) => di.locator<WatchCubit>()),
        BlocProvider(create: (_) => di.locator<PopularMovieCubit>()),
        BlocProvider(create: (_) => di.locator<TopRatedMovieCubit>()),
        BlocProvider(create: (_) => di.locator<NowPlayingMovieCubit>()),
        BlocProvider(create: (_) => di.locator<SearchCubit>()),
        BlocProvider(create: (_) => di.locator<OnAirTvCubit>()),
        BlocProvider(create: (_) => di.locator<PopularTvCubit>()),
        BlocProvider(create: (_) => di.locator<TopRatedTvCubit>()),
        BlocProvider(create: (_) => di.locator<TvDetailCubit>()),
        BlocProvider(create: (_) => di.locator<TvSeasonCubit>()),
        BlocProvider(create: (_) => di.locator<TvRecommendationCubit>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case POPULAR_MOVIE_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_MOVIE_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TV_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => TvSeriesPage());
            case ON_AIR_ROUTE:
              return CupertinoPageRoute(builder: (_) => OnAirTvPage());
            case POPULAR_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case SEARCH_ROUTE:
              final type = settings.arguments as Type;
              return CupertinoPageRoute(builder: (_) => SearchPage(type: type));
            case WATCHLIST_MOVIE_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TOP_RATED_TV_ROUTE:
              return MaterialPageRoute(builder: (_) => TopRatedTvPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found'),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
