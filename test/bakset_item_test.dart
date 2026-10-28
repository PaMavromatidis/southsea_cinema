import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  test('BasketItem calculates total price correctly', () {
    final movie = Movie(
      id: '1',
      title: 'Inception',
      synopsis: 'A mind-bending thriller.',
      ageRating: '12A',
      runtime: '148 minutes',
      screeningTime: '20:00',
      ticketPrice: 8.50,
      posterImage: 'assets/images/inception.jpg',
    );

    final basketItem = BasketItem(movie: movie, quantity: 3);

    expect(basketItem.totalPrice, 25.50);
  });
}
