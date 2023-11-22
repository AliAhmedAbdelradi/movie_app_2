import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/features/genre_movies/view/widgets/movie_genre_list_tile.dart';
import 'package:movies_app/features/genre_movies/view_model/genere_movies_listview.dart/genre_movies_listview_cubit.dart';
import 'package:movies_app/features/movie_details/view/movie_details_view.dart';
import 'package:movies_app/features/search/view/widgets/movie_search_list_view.dart';
import 'package:movies_app/features/search/view_model/movie_search_listview_cubit.dart/movie_search_listview_cubit.dart';
import 'package:movies_app/models/movie_details_model/movie_details_model.dart';

class GenreMoviesListView extends StatefulWidget {
  final List<MovieDetails> movies;
  final int genreId;
  const GenreMoviesListView({
    super.key,
    required this.movies,
    required this.genreId,
  });

  @override
  State<GenreMoviesListView> createState() => _GenreMoviesListViewState();
}

class _GenreMoviesListViewState extends State<GenreMoviesListView> {
  late ScrollController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent) {
        BlocProvider.of<GenreMoviesListViewCubit>(context)
            .fetchMoreData(widget.genreId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final genreMoviesCubit =
        BlocProvider.of<GenreMoviesListViewCubit>(context, listen: true);
    if (genreMoviesCubit.movies.isEmpty) {
      genreMoviesCubit.populateDataFirstTimeList(widget.movies);
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: genreMoviesCubit.movies.length,
            controller: controller,
            itemBuilder: (context, index) {
              return MovieGenreListTle(
                movieDetails: widget.movies[index],
              );
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        if (genreMoviesCubit.isLoadingMoreData == true)
          Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 40),
              child: SpinKitFadingCircle(
                color: AppColors.yellowColor,
                size: 36.sp,
              ),
            ),
          ),
        if (genreMoviesCubit.state is MovieSearchListviewCubitNoMoreData)
          NoMoreMoviesPaggination(
            message: "No more movies in genre",
          )
      ],
    );
  }
}
