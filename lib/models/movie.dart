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

  factory Movie.fromJson(Map<String, dynamic> json) {
    final String id = json['id'] as String;
    final String title = json['title'] as String;
    final String synopsis = json['synopsis'] as String;
    final String ageRating = json['ageRating'] as String;
    final String runtime = json['runtime'] as String;
    final String screeningTime = json['screeningTime'] as String;
    final double ticketPrice = (json['ticketPrice'] as num).toDouble();
    final String posterImage = json['posterImage'] as String;

    return Movie(
      id: id,
      title: title,
      synopsis: synopsis,
      ageRating: ageRating,
      runtime: runtime,
      screeningTime: screeningTime,
      ticketPrice: ticketPrice,
      posterImage: posterImage,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'synopsis': synopsis,
      'ageRating': ageRating,
      'runtime': runtime,
      'screeningTime': screeningTime,
      'ticketPrice': ticketPrice,
      'posterImage': posterImage,
    };
    return data;
  }

  String get formattedPrice => '£${ticketPrice.toStringAsFixed(2)}';
}
