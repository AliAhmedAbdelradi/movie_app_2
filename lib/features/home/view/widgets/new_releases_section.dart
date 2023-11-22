import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies_app/core/shared_widgets/custom_button.dart';
import 'package:movies_app/core/shared_widgets/movie_poster.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/features/home/view_model/upcoming_movies_cubit.dart/upcoming_movies_cubit.dart';
import 'package:movies_app/features/movie_details/view/movie_details_view.dart';

class NewReleasesSection extends StatefulWidget {
  const NewReleasesSection({
    super.key,
  });

  @override
  State<NewReleasesSection> createState() => _NewReleasesSectionState();
}

class _NewReleasesSectionState extends State<NewReleasesSection> {
  UpcomingMoviesCubit upcomingMoviesCubit = UpcomingMoviesCubit();

  @override
  void initState() {
    // TODO: implement initState
    upcomingMoviesCubit.getUpcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      width: double.infinity,
      height: 275.h,
      color: AppColors.darkColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Upcoming",
              style: AppStyles.textStyle18.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          //دا الكود في حالة Success
          BlocBuilder<UpcomingMoviesCubit, UpcomingMoviesState>(
            bloc: upcomingMoviesCubit,
            builder: (context, state) {
              if (state is UpcomingMoviesSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MovieDetailsView.routeName,
                              arguments: state.movies[index]);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: MoviePoster(
                            movie: state.movies[index],
                            height: 50.h,
                            aspectRatio: 65 / 100,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is UpcomingMoviesFailure) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage,
                          style: AppStyles.textStyle20,
                        ),
                        CustomButton(
                          onPressed: () {
                            upcomingMoviesCubit.getUpcomingMovies();
                          },
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: SpinKitFoldingCube(
                    size: 35.sp,
                    color: AppColors.yellowColor,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
