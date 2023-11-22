import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/api_constants.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/features/movie_details/view/movie_details_view.dart';
import 'package:movies_app/models/movie_details_model/movie_details_model.dart';

class MovieGenreListTle extends StatelessWidget {
  final MovieDetails movieDetails;
  const MovieGenreListTle({
    super.key,
    required this.movieDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, MovieDetailsView.routeName,
              arguments: movieDetails);
        },
        child: ListTile(
          visualDensity: VisualDensity(vertical: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              6,
            ),
          ),
          tileColor: AppColors.darkColor,
          title: Text(
            movieDetails.title ?? "",
            maxLines: 1,
            style: AppStyles.textStyle16,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            movieDetails.releaseDate ?? "0000",
            style: AppStyles.textStyle12.copyWith(
              color: AppColors.whiteColor.withOpacity(0.8),
            ),
          ),
          leading: CachedNetworkImage(
            width: 50,
            height: 100,
            fit: BoxFit.cover,
            imageUrl: "${ApiConstants.imagePrefix}${movieDetails.posterPath}",
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: AppColors.yellowColor,
                size: 24.sp,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                movieDetails.voteAverage ?? "0",
                style: AppStyles.textStyle14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
