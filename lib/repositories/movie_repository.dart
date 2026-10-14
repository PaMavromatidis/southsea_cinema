import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {

  List<Movie> getMovies() {
    return [
      Movie(
        id: '1',
        title: 'Interstellar',
        synopsis: 'A team of astronauts travels through space to find a new home for humanity.',
        ageRating: '12+',
        runtime: '169 minutes',
        screeningTime: '18:00',
        ticketPrice: 10.00,
        posterImage: 'assets/images/interstellar.jpg',
      ),

      Movie(
        id: '2',
        title: 'The Wolf of Wall Street',
        synopsis: 'The story of Jordan Belfort, a stockbroker who becomes wealthy through fraud and corruption.',
        ageRating: '18+',
        runtime: '180 minutes',
        screeningTime: '20:30',
        ticketPrice: 12.00,
        posterImage: 'assets/images/wolf_of_wall_street.jpg',
      ),
    ];
  }
}