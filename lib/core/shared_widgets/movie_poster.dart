import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/api_constants.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/cubits/watchlist_cubit/wishlist_cubit.dart';
import 'package:movies_app/models/movie_details_model/movie_details_model.dart';

class MoviePoster extends StatelessWidget {
  final double height;
  final double aspectRatio;
  final MovieDetails movie;
  const MoviePoster(
      {super.key,
      required this.height,
      required this.aspectRatio,
      required this.movie});

  @override
  Widget build(BuildContext context) {
    var watchListCubit = BlocProvider.of<WatchlistCubit>(context, listen: true);
    var isWishListed = watchListCubit.moviesBox.keys.contains(movie.id);
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: aspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                errorListener: (value) {
                  print(value);
                },
                imageUrl:
                    "${ApiConstants.imagePrefix}${movie.posterPath ?? "asdas"}",
                fit: BoxFit.cover,
                errorWidget: (context, str, ob) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.yellowColor.withOpacity(
                        1,
                      ),
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          "assets/images/placeholder.jpg",
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: InkWell(
                onTap: () {
                  watchListCubit.toggleWatchList(movie.id!, movie);
                },
                child: Container(
                  width: 32,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(!isWishListed
                          ? "assets/icons/bookmark_add.png"
                          : "assets/icons/bookmarked.png"),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
