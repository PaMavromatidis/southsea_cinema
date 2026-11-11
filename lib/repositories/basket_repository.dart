import 'package:southsea_cinema/models/basket_item.dart';

class BasketRepository {
  BasketRepository._internal();

  static final BasketRepository _instance = BasketRepository._internal();

  factory BasketRepository() {
    return _instance;
  }

  final List<BasketItem> _basketItems = [];

  List<BasketItem> get basketItems => List.unmodifiable(_basketItems);

  void addToBasket(BasketItem item) {
    _basketItems.add(item);
  }

  void removeFromBasket(BasketItem item) {
    _basketItems.remove(item);
  }

  void updateQuantity(BasketItem item, int newQuantity) {
    final index = _basketItems.indexOf(item);

    if (index != -1 && newQuantity >= 1 && newQuantity <= 5) {
      _basketItems[index] = BasketItem(
        movie: item.movie,
        quantity: newQuantity,
      );
    }
  }

  void clearBasket() {
    _basketItems.clear();
  }

  double get totalPrice {
    return _basketItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get serviceCharge {
    if (_basketItems.isEmpty) {
      return 0.0;
    }

    return 4.0;
  }

  double get totalDue {
    return totalPrice + serviceCharge;
  }
}
