import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/cubit/tv_detail/tv_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_detail/tv_detail_state.dart';
import 'package:ditonton/presentation/cubit/tv_season/tv_season_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_season/tv_season_state.dart';
import 'package:ditonton/presentation/cubit/tv_recommendation/tv_recommendation_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_recommendation/tv_recommendation_state.dart';
import 'package:ditonton/presentation/cubit/watch/watch_cubit.dart';
import 'package:ditonton/presentation/cubit/watch/watch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-detail';
  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvDetailCubit>(context, listen: false)
          .fetchTvSeriesDetail(widget.id);
      BlocProvider.of<WatchCubit>(context, listen: false)
          .isAddedToWatchlist(widget.id, Type.MOVIE);
      BlocProvider.of<TvRecommendationCubit>(context, listen: false)
          .fetchTvRecommendation(widget.id);
      // Provider.of<TvDetailNotifier>(context, listen: false)
      //   ..fetchTvSeriesDetail(widget.id)
      //   ..loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailCubit, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailLoaded) {
            final movie = state.tvDetail;

            return SafeArea(
              child: DetailContent(movie),
            );
          } else if (state is TvDetailError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tvDetail;

  DetailContent(this.tvDetail);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvDetail.originalName ?? "-",
                              style: kHeading5,
                            ),
                            BlocConsumer<WatchCubit, WatchState>(
                                listener: (context, state) {
                              if (state is WatchMessage) {
                                final message = state.message;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)));
                              } else if (state is WatchError) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(state.message),
                                      );
                                    });
                              }
                            }, builder: (context, state) {
                              context
                                  .read<WatchCubit>()
                                  .isAddedToWatchlist(tvDetail.id, Type.TV);

                              final isAdded = state is WatchCheckAdded
                                  ? state.isAdded
                                  : false;
                              return ElevatedButton(
                                onPressed: () {
                                  isAdded
                                      ? context
                                          .read<WatchCubit>()
                                          .removeWatchlistTv(tvDetail)
                                      : context
                                          .read<WatchCubit>()
                                          .addWatchlistTv(tvDetail);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isAdded
                                        ? Icon(Icons.check)
                                        : Icon(Icons.add),
                                    Text('Watchlist'),
                                  ],
                                ),
                              );
                            }),
                            Text(
                              _showGenres(tvDetail.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail.voteAverage}')
                              ],
                            ),
                            DefaultTabController(
                              length: tvDetail.seasons.length,
                              child: Builder(builder: (context) {
                                final TabController tabController =
                                    DefaultTabController.of(context)!;

                                var index = tabController.index;
                                BlocProvider.of<TvSeasonCubit>(context,
                                    listen: false)
                                    .fetchTvEpisodeBySeason(
                                    tvDetail.id,
                                    tvDetail.seasons[index].id,
                                    tvDetail
                                        .seasons[index].seasonNumber);
                                tabController.addListener(() {
                                  if (!tabController.indexIsChanging) {

                                    var index = tabController.index;
                                    BlocProvider.of<TvSeasonCubit>(context,
                                            listen: false)
                                        .fetchTvEpisodeBySeason(
                                            tvDetail.id,
                                            tvDetail.seasons[index].id,
                                            tvDetail
                                                .seasons[index].seasonNumber);
                                  }

                                  // Provider.of<TvDetailNotifier>(context,
                                  //         listen: false)
                                  //     .fetchTvEpisodeBySeason(
                                  //         tvDetail.id,
                                  //         tvDetail.seasons[index].id,
                                  //         tvDetail.seasons[index].seasonNumber);
                                });


                                return SizedBox(
                                  height: 200.0,
                                  child: Column(
                                    children: <Widget>[
                                      TabBar(
                                        isScrollable: true,
                                        tabs: <Widget>[
                                          for (var i in tvDetail.seasons)
                                            Tab(text: i.name ?? "-"),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: <Widget>[
                                            for (var i in tvDetail.seasons)
                                              Container(
                                                child: BlocBuilder<
                                                    TvSeasonCubit,
                                                    TvSeasonState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is TvSeasonLoaded) {
                                                      return Container(
                                                        height: 150,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final episodes =
                                                                (state.seasons[
                                                                        i.id] ??
                                                                    [])[index];
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  // Navigator.pushReplacementNamed(
                                                                  //   context,
                                                                  //   MovieDetailPage.ROUTE_NAME,
                                                                  //   arguments: movie.id,
                                                                  // );
                                                                },
                                                                child:
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius
                                                                                .all(
                                                                          Radius.circular(
                                                                              8),
                                                                        ),
                                                                        child:
                                                                            Stack(
                                                                          alignment:
                                                                              Alignment.bottomLeft,
                                                                          children: [
                                                                            CachedNetworkImage(
                                                                              imageUrl: 'https://image.tmdb.org/t/p/w500${episodes.stillPath ?? tvDetail.posterPath}',
                                                                              placeholder: (context, url) => Center(
                                                                                child: CircularProgressIndicator(),
                                                                              ),
                                                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                                                            ),
                                                                            Container(
                                                                              padding: EdgeInsets.all(10),
                                                                              decoration: BoxDecoration(
                                                                                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                                  Colors.black.withOpacity(0),
                                                                                  Colors.black.withOpacity(0.5)
                                                                                ]),
                                                                              ),
                                                                              child: Text(
                                                                                "S${episodes.seasonNumber}E${episodes.episodeNumber}",
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                              ),
                                                            );
                                                          },
                                                          itemCount:
                                                              (state.seasons[i
                                                                          .id] ??
                                                                      [])
                                                                  .length,
                                                        ),
                                                      );
                                                    } else {
                                                      return Container();
                                                    }
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvDetail.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecommendationCubit,
                                TvRecommendationState>(
                              builder: (context, state) {
                                if (state is TvRecommendationLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvRecommendationError) {
                                  return Text(state.message);
                                } else if (state is TvRecommendationLoaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = state.listTv[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.listTv.length,
                                    ),
                                  );
                                } else {
                                  return Container(
                                    key: Key("EmptyContainer"),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
