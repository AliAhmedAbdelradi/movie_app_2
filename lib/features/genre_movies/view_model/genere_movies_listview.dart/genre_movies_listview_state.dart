part of 'genre_movies_listview_cubit.dart';

@immutable
sealed class GenerMoviesListViewState {}

final class GenreMoviesListViewInitial extends GenerMoviesListViewState {}

final class GenreMoviesListViewLoadingData extends GenerMoviesListViewState {}

final class GenreMoviesListViewFinishedLoadingData
    extends GenerMoviesListViewState {}

final class GenreMoviesListViewNoMoreData extends GenerMoviesListViewState {}

final class GenreMoviesListViewFaliure extends GenerMoviesListViewState {
  final String errorMessage;

  GenreMoviesListViewFaliure({required this.errorMessage});
}
