part of 'genre_movies_cubit.dart';

@immutable
sealed class GenreMoviesState {}

final class GenreMoviesLoading extends GenreMoviesState {}

final class GenreMoviesSuccess extends GenreMoviesState {
  final List<MovieDetails> movies;

  GenreMoviesSuccess({required this.movies});
}

final class GenreMoviesFailure extends GenreMoviesState {
  final String errorMessage;

  GenreMoviesFailure({required this.errorMessage});
}
