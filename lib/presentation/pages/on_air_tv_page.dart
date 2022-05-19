import 'package:ditonton/presentation/cubit/on_air_tv/on_air_tv_cubit.dart';
import 'package:ditonton/presentation/cubit/on_air_tv/on_air_tv_state.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnAirTvPage extends StatefulWidget {
  const OnAirTvPage({Key? key}) : super(key: key);
  static const ROUTE_NAME = '/on-air-tv';

  @override
  _OnAirTvPageState createState() => _OnAirTvPageState();
}

class _OnAirTvPageState extends State<OnAirTvPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<OnAirTvCubit>(context, listen: false).fetchOnAirOnTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnAirTvCubit, OnAirTvState>(
          builder: (context, state) {
            if (state is OnAirTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnAirTvLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.listTv[index];
                  return TvSeriesCard(key: Key(tv.id.toString()), tv: tv);
                },
                itemCount: state.listTv.length,
              );
            } else if (state is OnAirTvError) {
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
