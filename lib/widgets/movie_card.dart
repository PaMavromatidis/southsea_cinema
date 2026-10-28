import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              movie.posterImage,
              height: 250,
            ),
            const SizedBox(height: 10),
            Text(
              movie.title,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 5),
            Text(
              'Age Rating: ${movie.ageRating}',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              movie.synopsis,
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              'Screening Time: ${movie.screeningTime}',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 15),
            PrimaryButton(
              label: 'Book Now',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieListing(movie: movie),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
