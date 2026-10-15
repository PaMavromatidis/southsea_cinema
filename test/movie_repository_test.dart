import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {

  group('MovieRepository unit tests', () {

    test('getMovies returns two movies', () {

      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 2);

    });


    test('getMovies contains the correct movies', () {

      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();
      final Movie interstellar = movies[0];

      expect(interstellar.id, '1');
      expect(interstellar.title, 'Interstellar');
      expect(interstellar.ageRating, '12A');
      expect(interstellar.ticketPrice, 10.00);
      expect(interstellar.posterImage, 'assets/images/interstellar.jpg');

      final Movie wolf = movies[1];

      expect(wolf.id, '2');
      expect(wolf.title, 'The Wolf of Wall Street');
      expect(wolf.ageRating, '18');
      expect(wolf.ticketPrice, 12.00);
      expect(wolf.posterImage, 'assets/images/wolf_of_wall_street.jpg');

    });


    test('getMovieById returns the correct movie', () {

      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('1');

      expect(movie, isNotNull);
      expect(movie?.title, 'Interstellar');
      expect(movie?.ticketPrice, 10.00);

    });


    test('getMovieById returns null for a missing ID', () {

      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('100');

      expect(movie, isNull);

    });

  });

}