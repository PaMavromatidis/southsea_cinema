import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  Future<List<Movie>> loadMovies() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/movies.json');

    final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;

    final List<Movie> movies = jsonList
        .map((item) => Movie.fromJson(item as Map<String, dynamic>))
        .toList();

    return movies;
  }

  List<Movie> getMovies() {
    return [
      Movie(
        id: '1',
        title: 'Interstellar',
        synopsis:
            'A team of astronauts travels through space to find a new home for humanity.',
        ageRating: '12A',
        runtime: '169 minutes',
        screeningTime: '18:00',
        ticketPrice: 10.00,
        posterImage: 'assets/images/interstellar.jpg',
      ),
      Movie(
        id: '2',
        title: 'The Wolf of Wall Street',
        synopsis:
            'The story of Jordan Belfort, a stockbroker who becomes wealthy through fraud and corruption.',
        ageRating: '18',
        runtime: '180 minutes',
        screeningTime: '20:30',
        ticketPrice: 12.00,
        posterImage: 'assets/images/wolf_of_wall_street.jpg',
      ),
    ];
  }

  Movie? getMovieById(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }
}
