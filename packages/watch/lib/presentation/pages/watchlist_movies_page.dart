import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch/presentation/cubic/watch_list/watch_list_cubit.dart';
import 'package:watch/presentation/cubic/watch_list/watch_list_state.dart';

class WatchlistMoviesPage extends StatefulWidget {

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchListCubit>(context, listen: false).fetchWatchlist());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<WatchListCubit>(context, listen: false).fetchWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchListCubit, WatchListState>(
          builder: (context, state) {
            if (state is WatchListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchListLoaded) {
              if (state.listWatch.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
            } else if (state is WatchListError) {
              return Center(
                key: const Key('error_message'),
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
