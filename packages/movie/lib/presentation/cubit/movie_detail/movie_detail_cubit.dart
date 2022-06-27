
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/get_movie_detail.dart';
import 'package:movie/presentation/cubit/movie_detail/movie_detail_state.dart';

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
