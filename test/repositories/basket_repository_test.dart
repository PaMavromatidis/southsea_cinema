import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

void main() {
  group('BasketRepository', () {
    late BasketRepository basketRepository;
    late Movie movie1;
    late Movie movie2;

    setUp(() {
      basketRepository = BasketRepository();
      movie1 = Movie(
        id: '1',
        title: 'Inception',
        synopsis: 'A mind-bending thriller.',
        ageRating: '12A',
        runtime: '148 minutes',
        screeningTime: '20:00',
        ticketPrice: 8.50,
        posterImage: 'assets/images/inception.jpg',
      );
      movie2 = Movie(
        id: '2',
        title: 'The Matrix',
        synopsis: 'A sci-fi classic.',
        ageRating: '15',
        runtime: '136 minutes',
        screeningTime: '22:00',
        ticketPrice: 9.00,
        posterImage: 'assets/images/matrix.jpg',
      );
      basketRepository.clearBasket();
    });

    test('Adding items to the basket increases the total price', () {
      final basketItem1 = BasketItem(movie: movie1, quantity: 2);
      final basketItem2 = BasketItem(movie: movie2, quantity: 1);

      basketRepository.addToBasket(basketItem1);
      basketRepository.addToBasket(basketItem2);

      expect(basketRepository.totalPrice, 26.0); // (2 * 8.50) + (1 * 9.00)
      expect(basketRepository.basketItems.length, 2);
    });

    test('Removing items from the basket decreases the total price', () {
      final basketItem1 = BasketItem(movie: movie1, quantity: 2);
      final basketItem2 = BasketItem(movie: movie2, quantity: 1);

      basketRepository.addToBasket(basketItem1);
      basketRepository.addToBasket(basketItem2);

      basketRepository.removeFromBasket(basketItem1);

      expect(basketRepository.totalPrice, 9.0); // Only the second item remains
    });

    test('Clearing the basket resets the total price to zero', () {
      final basketItem1 = BasketItem(movie: movie1, quantity: 2);
      final basketItem2 = BasketItem(movie: movie2, quantity: 1);

      basketRepository.addToBasket(basketItem1);
      basketRepository.addToBasket(basketItem2);

      basketRepository.clearBasket();

      expect(basketRepository.totalPrice, 0.0);
    });

    test('Basket is initially empty', () {
      expect(basketRepository.basketItems.length, 0);
      expect(basketRepository.totalPrice, 0.0);
      expect(basketRepository.basketItems, isEmpty);
    });
  });
}
