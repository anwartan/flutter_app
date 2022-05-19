import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/cubit/movie_detail/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {

  final GetMovieDetail getMovieDetail;

  MovieDetailCubit({
    required this.getMovieDetail,
  }) : super(MovieDetailEmpty());

  Future<void> fetchMovieDetail(int id) async {
    emit(MovieDetailLoading());
    final detailResult = await getMovieDetail.execute(id);
    detailResult.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (movie) {
        emit(MovieDetailHasData(movie));
      },
    );
  }

}
