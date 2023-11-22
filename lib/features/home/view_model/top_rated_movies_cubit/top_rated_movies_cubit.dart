import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/models/movie_details_model/movie_details_model.dart';
import 'package:movies_app/services/api_services.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  TopRatedMoviesCubit() : super(TopRatedMoviesLoading());
  Future<void> getTopRatedMovies() async {
    emit(TopRatedMoviesLoading());
    try {
      var response = await ApiService.getTopRatedMovies();
      if (response.statusCode != null) {
        emit(TopRatedMoviesFailure(errorMessage: response.statusMessage!));
      } else {
        emit(TopRatedMoviesSuccess(movies: response.results ?? []));
      }
    } on SocketException catch (e) {
      emit(TopRatedMoviesFailure(errorMessage: "No internet connection."));
    } catch (e) {
      emit(TopRatedMoviesFailure(errorMessage: e.toString()));
    }
  }
}
