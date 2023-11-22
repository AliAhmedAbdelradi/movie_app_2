part of 'top_rated_movies_cubit.dart';

@immutable
sealed class TopRatedMoviesState {}

final class TopRatedMoviesLoading extends TopRatedMoviesState {}

final class TopRatedMoviesSuccess extends TopRatedMoviesState {
  final List<MovieDetails> movies;

  TopRatedMoviesSuccess({required this.movies});
}

final class TopRatedMoviesFailure extends TopRatedMoviesState {
  final String errorMessage;

  TopRatedMoviesFailure({required this.errorMessage});
}
