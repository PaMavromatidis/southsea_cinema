import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() {
    return _MovieListingState();
  }
}


class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('INTERSTELLAR (2014) (12A)',style: TextStyle(fontSize: 28,),
            ),
            const SizedBox(height: 40),
            const Text('A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',style: TextStyle(fontSize: 18,),
            ),
            const SizedBox(height: 40),
            const Text('Southsea Cinema Room',style: TextStyle(fontSize: 18,),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text('Thursday 22 Oct 2026, 18:00',style: TextStyle(fontSize: 18,),
                ),
                SizedBox(width: 10),
                Text('- ends at 19:14',style: TextStyle(fontSize: 18,),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text('Please notethat Discounts / Membership Benefits will be applied once you have selected your tickets',style: TextStyle(fontSize: 18,),
            ),
            const SizedBox(height: 20),
            const Text('Select Quantities (Up tp 5 in total)',style: TextStyle(fontSize: 18,),
            ),
            const SizedBox(height: 40),
            const Text('Tickets',style: TextStyle(fontSize: 24,),
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
                const Text('  Adult (£7.50)',style: TextStyle(fontSize: 18,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}