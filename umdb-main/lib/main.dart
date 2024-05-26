import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:umdb/cubits/favourite_movie_cubit.dart';
import 'package:umdb/cubits/popular_movie_cubit.dart';
import 'package:umdb/cubits/top_rated_movie_cubit.dart';
import 'package:umdb/models/popular_movie_hive.dart';
import 'package:umdb/models/top_rated_movie_response.dart';
import 'package:umdb/pages/login_page.dart';
import 'package:umdb/pages/movie_grid_screen.dart';
import 'package:umdb/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PopularMovieAdapter()); // Registering Adapter
  await Hive.openBox<PopularMovieHive>('popular-movies');
  runApp(const UmdbApp());
}

class UmdbApp extends StatelessWidget {
  const UmdbApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => PopularMovieCubit()),
        BlocProvider(create: (BuildContext context) => FavouriteMovieCubit()),
        BlocProvider(create: (context) => TopRatedMovieCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MovieGridscreen(),
      ),
    );
  }
}
