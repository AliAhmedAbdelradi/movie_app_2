import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies_app/core/shared_widgets/custom_button.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/features/home/view/widgets/top_rated_movies_item.dart';
import 'package:movies_app/features/home/view_model/top_rated_movies_cubit/top_rated_movies_cubit.dart';
import 'package:movies_app/features/movie_details/view/movie_details_view.dart';

class TopRatedMoviesSection extends StatefulWidget {
  const TopRatedMoviesSection({
    super.key,
  });

  @override
  State<TopRatedMoviesSection> createState() => _TopRatedMoviesSectionState();
}

class _TopRatedMoviesSectionState extends State<TopRatedMoviesSection> {
  TopRatedMoviesCubit topRatedViewModel = TopRatedMoviesCubit();

  @override
  void initState() {
    // TODO: implement initState
    topRatedViewModel.getTopRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      width: double.infinity,
      height: 350.h,
      color: AppColors.darkColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Top rated",
              style: AppStyles.textStyle18.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),

          // دا في حالة الساكسيس
          BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
            bloc: topRatedViewModel,
            builder: (context, state) {
              if (state is TopRatedMoviesSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.movies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MovieDetailsView.routeName,
                              arguments: state.movies[index]);
                        },
                        child: TopRatedMovieItem(
                          movie: state.movies[index],
                        ),
                      );
                    },
                  ),
                );
              } else if (state is TopRatedMoviesFailure) {
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
                            topRatedViewModel.getTopRatedMovies();
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
          )
        ],
      ),
    );
  }
}
