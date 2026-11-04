import 'package:flutter/material.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/models/basket_item.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() {
    return _BasketViewState();
  }
}

class _BasketViewState extends State<BasketView> {
  final BasketRepository basketRepository = BasketRepository();
  final Map<BasketItem, int> selectedQuantities = {};

  String _confirmationMessage = '';

  void _updateOrder() {
    setState(() {
      selectedQuantities.forEach((item, quantity) {
        basketRepository.updateQuantity(item, quantity);
      });

      selectedQuantities.clear();
    });
  }

  void _buyTickets() {
    setState(() {
      basketRepository.clearBasket();
      selectedQuantities.clear();

      _confirmationMessage = 'Thank you! Your tickets have been purchased.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final basketItems = basketRepository.basketItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
      ),
      body: basketItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Your basket is empty',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _confirmationMessage,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
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
                        subtitle: Row(
                          children: [
                            const Text(
                              'Tickets: ',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            DropdownButton<int>(
                              value: selectedQuantities[item] ?? item.quantity,
                              dropdownColor: Colors.grey[850],
                              items: [1, 2, 3, 4, 5].map((quantity) {
                                return DropdownMenuItem<int>(
                                  value: quantity,
                                  child: Text(
                                    '$quantity',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (int? value) {
                                if (value != null) {
                                  setState(() {
                                    selectedQuantities[item] = value;
                                  });
                                }
                              },
                            ),
                            const SizedBox(width: 15),
                            Text(
                              '£${item.totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
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
                      Column(
                        children: [
                          Text(
                            'Ticket Subtotal: £${basketRepository.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Service Charge: £${basketRepository.serviceCharge.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Total Due: £${basketRepository.totalDue.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: _updateOrder,
                            child: const Text('UPDATE ORDER'),
                          ),
                          ElevatedButton(
                            onPressed: _buyTickets,
                            child: const Text('BUY TICKETS'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
