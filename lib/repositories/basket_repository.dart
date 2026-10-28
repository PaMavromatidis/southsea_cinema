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

  void clearBasket() {
    _basketItems.clear();
  }

  double get totalPrice {
    return _basketItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
}
