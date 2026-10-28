import 'package:flutter/material.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() {
    return _BasketViewState();
  }
}

class _BasketViewState extends State<BasketView> {
  final BasketRepository basketRepository = BasketRepository();

  @override
  Widget build(BuildContext context) {
    final basketItems = basketRepository.basketItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
      ),
      body: basketItems.isEmpty
          ? const Center(
              child: Text(
                'Your basket is empty',
                style: TextStyle(fontSize: 20),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: basketItems.length,
                    itemBuilder: (context, index) {
                      final item = basketItems[index];
                      return ListTile(
                        title: Text(
                          item.movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Tickets: ${item.quantity} | £${item.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              basketRepository.removeFromBasket(item);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Total: £${basketRepository.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            basketRepository.clearBasket();
                          });
                        },
                        child: const Text('Clear Basket'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
