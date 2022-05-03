import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

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
      Provider.of<TvDetailNotifier>(context, listen: false)
          ..fetchTvSeriesDetail(widget.id)
          ..loadWatchlistStatus(widget.id);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvState == RequestState.Loaded) {
            final movie = provider.tvDetail;
            return SafeArea(
              child: DetailContent(
                movie,
                provider.tvRecommendations,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tvDetail;
  final List<Tv> tvListRecommendation;
  final bool isAddedWatchlist;

  DetailContent(
      this.tvDetail, this.tvListRecommendation, this.isAddedWatchlist);

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
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  await Provider.of<TvDetailNotifier>(context,
                                          listen: false)
                                      .addWatchlist(tvDetail);
                                } else {
                                  await Provider.of<TvDetailNotifier>(context,
                                          listen: false)
                                      .removeFromWatchlist(tvDetail);
                                }

                                final message = Provider.of<TvDetailNotifier>(
                                        context,
                                        listen: false)
                                    .watchlistMessage;

                                if (message ==
                                        TvDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TvDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
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
                                tabController.addListener(() {
                                  var index = tabController.index;
                                  Provider.of<TvDetailNotifier>(context,
                                          listen: false)
                                      .fetchTvEpisodeBySeason(
                                          tvDetail.id,
                                          tvDetail.seasons[index].id,
                                          tvDetail.seasons[index].seasonNumber);
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
                                                child:
                                                    Consumer<TvDetailNotifier>(
                                                  builder:
                                                      (context, data, child) {
                                                    if (data.seasonState ==
                                                        RequestState.Loaded) {
                                                      return Container(
                                                        height: 150,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final episodes =
                                                                (data.seasons[
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
                                                              (data.seasons[i
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
                            Consumer<TvDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.Error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.Loaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie =
                                            tvListRecommendation[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.pushReplacementNamed(
                                              //   context,
                                              //   MovieDetailPage.ROUTE_NAME,
                                              //   arguments: movie.id,
                                              // );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                                      itemCount: tvListRecommendation.length,
                                    ),
                                  );
                                } else {
                                  return Container();
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

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
