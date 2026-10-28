import 'package:flutter/material.dart';

class BasketView extends StatelessWidget {
  const BasketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
      ),
      body: const Center(
        child: Text('Basket View'),
      ),
    );
  }
}