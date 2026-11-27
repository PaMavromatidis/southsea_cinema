import 'package:material_ui/material_ui.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking.dart';

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
  List<Booking> _bookings = [];
  bool _loading = true;
  String _errorMessage = '';
  bool _isBuying = false;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _updateOrder() {
    if (_isBuying) {
      return;
    }
    setState(() {
      selectedQuantities.forEach((item, quantity) {
        basketRepository.updateQuantity(item, quantity);
      });

      selectedQuantities.clear();
    });
  }

  String _formatDate(DateTime now) {
    final String day = now.day.toString().padLeft(2, '0');
    final String month = now.month.toString().padLeft(2, '0');
    final String hour = now.hour.toString().padLeft(2, '0');
    final String minute = now.minute.toString().padLeft(2, '0');

    return '$day/$month/${now.year} $hour:$minute';
  }

  Future<void> _buyTickets() async {
    if (_isBuying || basketRepository.basketItems.isEmpty) {
      return;
    }

    setState(() {
      _isBuying = true;
      _confirmationMessage = '';
    });

    final String summary = basketRepository.basketItems
        .map((item) => '${item.quantity} x ${item.movie.title}')
        .join(', ');

    final double total = basketRepository.totalDue;
    final String date = _formatDate(DateTime.now());

    try {
      final int bookingNumber =
          await CinemaDatabase.instance.getNextBookingNumber();

      final Booking booking = Booking(
        bookingNumber: bookingNumber,
        summary: summary,
        total: total,
        date: date,
      );

      await CinemaDatabase.instance.insertBooking(booking);

      basketRepository.clearBasket();
      selectedQuantities.clear();

      if (!mounted) {
        return;
      }

      setState(() {
        _confirmationMessage = 'Thank you! Your tickets have been purchased. '
            'Booking number: $bookingNumber';
      });
      await _loadBookings();
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to save booking. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isBuying = false;
        });
      }
    }
  }

  Future<void> _loadBookings() async {
    try {
      final List<Booking> bookings =
          await CinemaDatabase.instance.getAllBookings();

      if (!mounted) {
        return;
      }

      setState(() {
        _bookings = bookings;
        _loading = false;
        _errorMessage = '';
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;
        _errorMessage = 'Unable to load bookings.';
      });
    }
  }

  Widget _buildBookingHistory() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Text(_errorMessage);
    }

    if (_bookings.isEmpty) {
      return const Text('No previous bookings.');
    }

    return Column(
      children: _bookings.map((booking) {
        return Card(
          child: ListTile(
            title: Text('Booking #${booking.bookingNumber}'),
            subtitle: Text(
              '${booking.summary}\n${booking.date}',
            ),
            trailing: Text(
              '£${booking.total.toStringAsFixed(2)}',
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final basketItems = basketRepository.basketItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
      ),
      drawer: const NavDrawer(),
      body: Column(
        children: [
          Expanded(
            child: basketItems.isEmpty
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
                                    value: selectedQuantities[item] ??
                                        item.quantity,
                                    dropdownColor: Colors.grey[850],
                                    items: [1, 2, 3, 4, 5].map((quantity) {
                                      return DropdownMenuItem<int>(
                                        value: quantity,
                                        child: Text(
                                          '$quantity',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: _isBuying
                                        ? null
                                        : (int? value) {
                                            if (value != null) {
                                              setState(() {
                                                selectedQuantities[item] =
                                                    value;
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
                                onPressed: _isBuying
                                    ? null
                                    : () {
                                        setState(() {
                                          basketRepository
                                              .removeFromBasket(item);
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
                                PrimaryButton(
                                  label: 'UPDATE ORDER',
                                  onPressed: _updateOrder,
                                ),
                                PrimaryButton(
                                  label: 'BUY TICKETS',
                                  onPressed: _buyTickets,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
          const Divider(),
          const Text(
            'Booking History',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: _buildBookingHistory(),
            ),
          ),
        ],
      ),
    );
  }
}
