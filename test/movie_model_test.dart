import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {

  group('Movie model tests', () {

    test('Movie constructor assigns properties correctly', () {

      final movie = Movie(
        id: '1',
        title: 'Interstellar',
        synopsis: 'A team of astronauts travels through space.',
        ageRating: '12A',
        runtime: '169 minutes',
        screeningTime: '18:00',
        ticketPrice: 10.00,
        posterImage: 'assets/images/interstellar.jpg',
      );

      expect(movie.id, '1');
      expect(movie.title, 'Interstellar');
      expect(movie.synopsis, 'A team of astronauts travels through space.');
      expect(movie.ageRating, '12A');
      expect(movie.runtime, '169 minutes');
      expect(movie.screeningTime, '18:00');
      expect(movie.ticketPrice, 10.00);
      expect(movie.posterImage, 'assets/images/interstellar.jpg');

    });

    test('formattedPrice displays whole-pound prices correctly', () {

      final movie = Movie(
        id: '1',
        title: 'Interstellar',
        synopsis: 'A team of astronauts travels through space.',
        ageRating: '12A',
        runtime: '169 minutes',
        screeningTime: '18:00',
        ticketPrice: 10.00,
        posterImage: 'assets/images/interstellar.jpg',
      );

      expect(movie.formattedPrice, '£10.00');

    });

    test('formattedPrice displays prices with pence correctly', () {

      final movie = Movie(
        id: '2',
        title: 'The Wolf of Wall Street',
        synopsis: 'The story of Jordan Belfort.',
        ageRating: '18',
        runtime: '180 minutes',
        screeningTime: '20:30',
        ticketPrice: 7.50,
        posterImage: 'assets/images/wolf_of_wall_street.jpg',
      );

      expect(movie.formattedPrice, '£7.50');

    });

  });

}