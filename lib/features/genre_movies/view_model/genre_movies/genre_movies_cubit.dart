import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/models/movie_details_model/movie_details_model.dart';
import 'package:movies_app/services/api_services.dart';

part 'genre_movies_state.dart';

class GenreMoviesCubit extends Cubit<GenreMoviesState> {
  GenreMoviesCubit() : super(GenreMoviesLoading());

  void getMoviesByGenreId(int genreId) async {
    emit(GenreMoviesLoading());

    try {
      var response = await ApiService.getMoviesByGenreId(genreId, 1);

      if (response.statusCode != null) {
        emit(GenreMoviesFailure(errorMessage: response.statusMessage!));
      } else {
        emit(GenreMoviesSuccess(movies: response.results!));
      }
    } on SocketException catch (e) {
      emit(GenreMoviesFailure(errorMessage: "No internet connection."));
    } on Exception catch (e) {
      emit(GenreMoviesFailure(errorMessage: e.toString()));
    }
  }
}
