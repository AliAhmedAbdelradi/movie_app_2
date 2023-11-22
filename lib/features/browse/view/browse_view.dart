import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/features/browse/view/widgets/custom_genre_container.dart';
import 'package:movies_app/features/genre_movies/view/genre_movies.dart';
import 'package:movies_app/models/genre_model/genre_model.dart';

class BrowseView extends StatelessWidget {
  static const String routeName = "browse-Screen";
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    List genreList = GenreDM.getGenres();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 70.sp),
          Text(
            "Browse Genre",
            style:
                AppStyles.textStyle22.copyWith(fontWeight: FontWeight.normal),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 38.sp,
                  crossAxisSpacing: 47.sp,
                  childAspectRatio: 1.5),
              itemBuilder: (context, index) {
                return InkWell(
                    splashColor: AppColors.yellowColor.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        GenreMovies.routeName,
                        arguments: genreList[index] as GenreDM,
                      );
                    },
                    child: CustomGenreContainer(
                        genre: genreList[index], index: index));
              },
              itemCount: genreList.length,
            ),
          )
        ],
      ),
    );
  }
}
