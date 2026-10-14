import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/constants.dart';

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

            Image.asset(movie.posterImage, height: 250,),

            const SizedBox(height: 10),
            Text(movie.title, style: cinemaHeaderStyle,),
            const SizedBox(height: 5),
            Text('Age Rating: ${movie.ageRating}'),
            const SizedBox(height: 10),
            Text(movie.synopsis),
            const SizedBox(height: 10),
            Text('Screening Time: ${movie.screeningTime}'),
            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                print('Booking selected for ${movie.title}');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cinemaBrand,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text('Book Now', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}