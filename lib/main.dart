import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/core/utils/app_theme.dart';
import 'package:movies_app/cubits/watchlist_cubit/wishlist_cubit.dart';
import 'package:movies_app/features/genre_movies/view/genre_movies.dart';
import 'package:movies_app/features/movie_details/view/movie_details_view.dart';
import 'package:movies_app/features/root/view/root_view.dart';
import 'package:movies_app/models/movie_details_model/movie_details_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 3));
  await Hive.initFlutter();
  Hive.registerAdapter(MovieDetailsAdapter());
  await Hive.openBox<MovieDetails>("moviesBox");
  FlutterNativeSplash.remove();

  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchlistCubit()..populateList(),
      child: ScreenUtilInit(
        designSize: const Size(412, 870),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movies App',
            theme: AppTheme.mainTheme,
            initialRoute: RootView.routeName,
            routes: {
              RootView.routeName: (context) => const RootView(),
              MovieDetailsView.routeName: (context) => const MovieDetailsView(),
              GenreMovies.routeName: (context) => const GenreMovies(),
            },
          );
        },
      ),
    );
  }
}
