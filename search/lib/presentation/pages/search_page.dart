import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/cubit/search/search_cubit.dart';
import 'package:search/presentation/cubit/search/search_state.dart';

class SearchPage extends StatefulWidget {
  final Type type;
  const SearchPage({Key? key, required this.type}) : super(key: key);
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
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            if (widget.type == Type.MOVIE)
              BlocBuilder<SearchCubit,SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        key: Key("Movie"),
                      ),
                    );
                  } else if (state is SearchMovieLoaded) {
                    final result = state.movies;
                    if (result.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
                        key: const Key("emptyContainerMovie"),
                      ),
                    );
                  }
                },
              )
            else if (widget.type == Type.TV)
              BlocBuilder<SearchCubit,SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        key: Key("TV"),
                      ),
                    );
                  } else if (state is SearchTvLoaded) {
                    final result = state.tv;
                    if (result.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
                        key: const Key("emptyContainerTv"),
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
