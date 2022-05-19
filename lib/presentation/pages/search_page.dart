import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/enum.dart';
import 'package:ditonton/presentation/cubit/search/search_cubit.dart';
import 'package:ditonton/presentation/cubit/search/search_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';
  final Type type;
  SearchPage({required this.type});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Search ${widget.type == Type.TV ? "TV Series" : widget.type == Type.MOVIE ? "Movie" : ""}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                if (widget.type == Type.MOVIE) {
                  BlocProvider.of<SearchCubit>(context, listen: false)
                      .fetchMovieSearch(query);
                } else if (widget.type == Type.TV) {
                  BlocProvider.of<SearchCubit>(context, listen: false)
                      .fetchTvSearch(query);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            if (widget.type == Type.MOVIE)
              BlocBuilder<SearchCubit,SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        key: Key("Movie"),
                      ),
                    );
                  } else if (state is SearchMovieLoaded) {
                    final result = state.movies;
                    if (result.length == 0) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.movie, size: 70, key: Key('empty')),
                            Text("Nothing found!")
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = result[index];
                          return MovieCard(
                              key: Key(movie.id.toString()), movie: movie);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(
                        key: Key("emptyContainerMovie"),
                      ),
                    );
                  }
                },
              )
            else if (widget.type == Type.TV)
              BlocBuilder<SearchCubit,SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        key: Key("TV"),
                      ),
                    );
                  } else if (state is SearchTvLoaded) {
                    final result = state.tv;
                    if (result.length == 0) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.movie, size: 70, key: Key('empty')),
                            Text("Nothing found!")
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final tv = result[index];
                          return TvSeriesCard(
                              key: Key(tv.id.toString()), tv: tv);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(
                        key: Key("emptyContainerTv"),
                      ),
                    );
                  }
                },
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }
}
