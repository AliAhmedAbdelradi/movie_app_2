import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/models/movie_details_model/movie_details_model.dart';
import 'package:movies_app/services/api_services.dart';

part 'upcoming_movies_state.dart';

class UpcomingMoviesCubit extends Cubit<UpcomingMoviesState> {
  UpcomingMoviesCubit() : super(UpcomingMoviesLoading());
  Future<void> getUpcomingMovies() async {
    emit(UpcomingMoviesLoading());
    try {
      var response = await ApiService.getUpcomingMovies();
      if (response.statusCode != null) {
        emit(UpcomingMoviesFailure(errorMessage: response.statusMessage!));
      } else {
        emit(UpcomingMoviesSuccess(movies: response.results ?? []));
      }
    } on SocketException catch (e) {
      emit(UpcomingMoviesFailure(errorMessage: "No internet connection."));
    } catch (e) {
      emit(UpcomingMoviesFailure(errorMessage: e.toString()));
    }
  }
}
