import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_on_tv.dart';
import 'package:search/presentation/cubit/search/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchMovies searchMovies;
  final SearchOnTv searchOnTv;
  SearchCubit(this.searchMovies, this.searchOnTv) : super(SearchInitialState());

  Future<void> fetchMovieSearch(String query) async {
    emit(SearchLoading());

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        emit(SearchError(failure.message));
      },
      (data) {
        emit(SearchMovieLoaded(data));
      },
    );
  }

  Future<void> fetchTvSearch(String query) async {
    emit(SearchLoading());

    final result = await searchOnTv.execute(query);
    result.fold(
      (failure) {
        emit(SearchError(failure.message));
      },
      (data) {
        emit(SearchTvLoaded(data));
      },
    );
  }
}
