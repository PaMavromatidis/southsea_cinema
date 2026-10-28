import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({super.key, required this.movie});

  @override
  State<MovieListing> createState() {
    return _MovieListingState();
  }
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 0;
  String _bookingMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.movie.title} (${widget.movie.ageRating})',
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 40),
              Text(
                widget.movie.synopsis,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              const Text(
                'Southsea Cinema Room',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Text(
                'Screening Time: ${widget.movie.screeningTime}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              const Text(
                'Please note that Discounts / Membership Benefits will be applied once you have selected your tickets',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Quantities (Up to 5 in total)',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              const Text(
                'Tickets',
                style: TextStyle(fontSize: 24),
              ),
              Row(
                children: [
                  DropdownMenu<int>(
                    initialSelection: 0,
                    onSelected: (int? value) {
                      if (value != null) {
                        setState(() {
                          _ticketQuantity = value;
                        });
                      }
                    },
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 0, label: '0'),
                      DropdownMenuEntry(value: 1, label: '1'),
                      DropdownMenuEntry(value: 2, label: '2'),
                      DropdownMenuEntry(value: 3, label: '3'),
                      DropdownMenuEntry(value: 4, label: '4'),
                      DropdownMenuEntry(value: 5, label: '5'),
                    ],
                  ),
                  Text(
                    '  Adult (${widget.movie.formattedPrice})',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                label: 'Add to Order',
                onPressed: () {
                  if (_ticketQuantity > 0) {
                    final basketItem = BasketItem(
                      movie: widget.movie,
                      quantity: _ticketQuantity,
                    );
                    BasketRepository().addToBasket(basketItem);
                    setState(() {
                      _bookingMessage =
                          '$_ticketQuantity tickets added to your order for ${widget.movie.title}';
                    });
                  } else {
                    setState(() {
                      _bookingMessage = 'Please select at least one ticket';
                    });
                  }
                },
              ),
              const SizedBox(height: 5),
              Text(
                _bookingMessage,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
