import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/cubit/popular_tv/popular_tv_cubit.dart';
import 'package:tv/presentation/cubit/popular_tv/popular_tv_state.dart';

class PopularTvPage extends StatefulWidget {

  const PopularTvPage({Key? key}) : super(key: key);

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<PopularTvCubit>(context, listen: false)
            .fetchPopularOnTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvCubit, PopularTvState>(
          builder: (context, state) {
            if (state is PopularTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.listTv[index];
                  return TvSeriesCard(key: Key(tv.id.toString()), tv: tv);
                },
                itemCount: state.listTv.length,
              );
            } else if (state is PopularTvError) {
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
}
