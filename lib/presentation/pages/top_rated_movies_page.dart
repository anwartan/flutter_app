import 'package:ditonton/presentation/cubit/top_rated_movie/top_rated_movie_cubit.dart';
import 'package:ditonton/presentation/cubit/top_rated_movie/top_rated_movie_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        BlocProvider.of<TopRatedMovieCubit>(context, listen: false)
            .fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
          builder: (context, state) {
            if (state is TopRatedMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMovieLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(key: Key(movie.id.toString()), movie: movie);
                },
                itemCount: state.movies.length,
              );
            } else if (state is TopRatedMovieError) {
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
}
