import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  test('Movie.fromJson creates a Movie from JSON', () {
    final Map<String, dynamic> json = {
      'id': '1',
      'title': 'Interstellar',
      'synopsis':
          'A team of astronauts travels through space to find a new home for humanity.',
      'ageRating': '12A',
      'runtime': '169 minutes',
      'screeningTime': '18:00',
      'ticketPrice': 10,
      'posterImage': 'assets/images/interstellar.jpg',
    };

    final Movie movie = Movie.fromJson(json);

    expect(movie.id, '1');
    expect(movie.title, 'Interstellar');
    expect(
      movie.synopsis,
      'A team of astronauts travels through space to find a new home for humanity.',
    );
    expect(movie.ageRating, '12A');
    expect(movie.runtime, '169 minutes');
    expect(movie.screeningTime, '18:00');
    expect(movie.ticketPrice, 10.0);
    expect(movie.ticketPrice, isA<double>());
    expect(movie.posterImage, 'assets/images/interstellar.jpg');
  });



  test('Movie.toJson converts a Movie to JSON', () {
    final Movie movie = Movie(
      id: '1',
      title: 'Wolf of Wall Street',
      synopsis: 'The story of Jordan Belfort, a stockbroker who becomes wealthy through fraud and corruption.',
      ageRating: '18',
      runtime: '180 minutes',
      screeningTime: '20:30',
      ticketPrice: 12.0,
      posterImage: 'assets/images/wolf_of_wall_street.jpg',
    );

    final Map<String, dynamic> json = movie.toJson();

    expect(json['title'], 'Wolf of Wall Street');
    expect(json['synopsis'], 'The story of Jordan Belfort, a stockbroker who becomes wealthy through fraud and corruption.');
    expect(json['ageRating'], '18');
    expect(json['runtime'], '180 minutes');
    expect(json['screeningTime'], '20:30');
    expect(json['ticketPrice'], 12.0);
  });
}
