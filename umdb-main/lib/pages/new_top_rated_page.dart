import 'package:flutter/material.dart';
import 'package:umdb/pages/top_rated_movies_page.dart';

class NewTopRatedMovies extends StatefulWidget {
  const NewTopRatedMovies({super.key});

  @override
  State<NewTopRatedMovies> createState() => _NewTopRatedMoviesState();
}

class _NewTopRatedMoviesState extends State<NewTopRatedMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Top Rated Movies',style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      body: const TopRatedMoviesPage(),
    );
  }
}