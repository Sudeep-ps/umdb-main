import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:umdb/pages/new_popular_page.dart';
import 'package:umdb/pages/new_top_rated_page.dart';

import '../models/movie.dart';

class MovieGridscreen extends StatefulWidget {
  const MovieGridscreen({super.key});

  @override
  State<MovieGridscreen> createState() => _MovieGridscreenState();
}

class _MovieGridscreenState extends State<MovieGridscreen> {
  Future<MovieList>? topRatedMovies;
  Future<MovieList>? futureMovies;

  Future<MovieList> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/popular_movies.json');
    final jsonResponse = json.decode(jsonString);
    return MovieList.fromJson(jsonResponse);
  }

  Future<MovieList> fetchTopRatedMovies() async {
    final response = await http.get(Uri.parse('https://movie-api-rish.onrender.com/top-rated'));

    if (response.statusCode == 200) {
      final jsonResponse2 = json.decode(response.body);
      return MovieList.fromJson(jsonResponse2);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void initState() {
    super.initState();
    futureMovies = loadJsonData();
    topRatedMovies = fetchTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text('MOVIE APP',style: TextStyle(fontSize: 30,fontFamily: GoogleFonts.bungee().fontFamily,),)),
      ),
      backgroundColor: Color.fromARGB(255, 151, 222, 255),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Movies',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NewPopularMovies()),
                        );
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),


            Expanded(
              child: FutureBuilder<MovieList>(
                future: futureMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final movies = snapshot.data?.items ?? [];
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 2 rows and 3 columns
                      ),
                      
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color.fromARGB(255, 121, 169, 194),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(movies[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(movies[index].year),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Rated Movies',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewTopRatedMovies()),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: FutureBuilder<MovieList>(
                future: topRatedMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final topMovies = snapshot.data?.items ?? [];
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,// 2 rows and 3 columns
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color.fromARGB(255, 121, 169, 194),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(topMovies[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(topMovies[index].year),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}