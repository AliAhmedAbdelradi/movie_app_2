import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/features/genre_movies/view/widgets/genre_movies_body.dart';
import 'package:movies_app/models/genre_model/genre_model.dart';

class GenreMovies extends StatelessWidget {
  static String routeName = "genre-movies";
  const GenreMovies({super.key});

  @override
  Widget build(BuildContext context) {
    var genreArgs = ModalRoute.of(context)!.settings.arguments as GenreDM;

    return Scaffold(
      appBar: AppBar(
        // surfaceTintColor: Colors.transparent,

        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: Text(
          genreArgs.genreTitle,
          style: AppStyles.textStyle22.copyWith(
            fontSize: 26.sp,
          ),
        ),
        elevation: 0,
      ),
      body: GenreMoviesBody(genreId: genreArgs.id),
    );
  }
}
