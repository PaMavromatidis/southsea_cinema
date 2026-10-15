class Movie {
  final String id;
  final String title;
  final String synopsis;
  final String ageRating;
  final String runtime;
  final String screeningTime;
  final double ticketPrice;
  final String posterImage;

  Movie({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.ageRating,
    required this.runtime,
    required this.screeningTime,
    required this.ticketPrice,
    required this.posterImage,
  });

  String get formattedPrice => '£${ticketPrice.toStringAsFixed(2)}';
}