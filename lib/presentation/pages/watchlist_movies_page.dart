import 'package:ditonton/common/enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/cubit/watch/watch_cubit.dart';
import 'package:ditonton/presentation/cubit/watch/watch_state.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchCubit>(context, listen: false).fetchWatchlist());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchCubit, WatchState>(
          builder: (context, state) {
            if (state is WatchLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchListLoaded) {
              if (state.listWatch.length == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.movie,
                        size: 70,
                        key: Key('empty'),
                      ),
                      Text("Nothing found!")
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final watch = state.listWatch[index];
                  if (watch.type == Type.MOVIE) {
                    final movie = watch.copyToMovie();
                    return MovieCard(
                        key: Key(movie.id.toString()), movie: movie);
                  } else {
                    final tv = watch.copyToTv();
                    return TvSeriesCard(key: Key(tv.id.toString()), tv: tv);
                  }
                },
                itemCount: state.listWatch.length,
              );
            } else if (state is WatchError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
