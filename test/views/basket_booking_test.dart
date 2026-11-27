import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/models/basket_item.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
  });

  setUp(() async {
    BasketRepository().clearBasket();

    final Database db = await databaseFactoryFfiNoIsolate.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: CinemaDatabase.instance.createTables,
      ),
    );

    CinemaDatabase.instance.setDatabase(db);
  });

  tearDown(() async {
    await CinemaDatabase.instance.close();
    BasketRepository().clearBasket();
  });

  testWidgets('Displays message when no bookings exist', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      await tester.pumpAndSettle();
    });

    await tester.pumpAndSettle();

    expect(find.text('Booking History'), findsOneWidget);
    expect(find.text('No previous bookings.'), findsOneWidget);
  });

  testWidgets('Displays bookings in descending order', (tester) async {
    await CinemaDatabase.instance.insertBooking(
      const Booking(
        bookingNumber: 1001,
        summary: '2 x Interstellar',
        total: 20.00,
        date: '25/11/2026 18:30',
      ),
    );

    await CinemaDatabase.instance.insertBooking(
      const Booking(
        bookingNumber: 1003,
        summary: '1 x Inception',
        total: 10.00,
        date: '27/11/2026 19:30',
      ),
    );

    await CinemaDatabase.instance.insertBooking(
      const Booking(
        bookingNumber: 1002,
        summary: '3 x Interstellar',
        total: 30.00,
        date: '26/11/2026 20:30',
      ),
    );

    await tester.runAsync(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      await tester.pumpAndSettle();
    });

    await tester.pumpAndSettle();

    expect(find.text('Booking #1003'), findsOneWidget);
    expect(find.text('Booking #1002'), findsOneWidget);
    expect(find.text('Booking #1001'), findsOneWidget);

    expect(
      tester.getTopLeft(find.text('Booking #1003')).dy,
      lessThan(tester.getTopLeft(find.text('Booking #1002')).dy),
    );

    expect(
      tester.getTopLeft(find.text('Booking #1002')).dy,
      lessThan(tester.getTopLeft(find.text('Booking #1001')).dy),
    );
  });

  testWidgets('Successful checkout saves booking and clears basket',
      (tester) async {
    final Movie movie = Movie(
      id: '1',
      title: 'Interstellar',
      synopsis: 'A science fiction movie.',
      ageRating: '12A',
      runtime: '169 minutes',
      screeningTime: '18:30',
      ticketPrice: 10.00,
      posterImage: '',
    );

    BasketRepository().addToBasket(
      BasketItem(
        movie: movie,
        quantity: 2,
      ),
    );

    await tester.runAsync(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('BUY TICKETS'));
      await tester.pumpAndSettle();

      final List<Booking> bookings =
          await CinemaDatabase.instance.getAllBookings();

      expect(bookings.length, 1);
      expect(bookings.first.bookingNumber, 1001);
      expect(bookings.first.summary, '2 x Interstellar');
      expect(bookings.first.total, 24.00);
    });

    await tester.pumpAndSettle();

    expect(BasketRepository().basketItems, isEmpty);
    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(find.textContaining('Booking number: 1001'), findsOneWidget);
    expect(find.text('Booking #1001'), findsOneWidget);
  });

  testWidgets('Failed checkout preserves basket', (tester) async {
    final Movie movie = Movie(
      id: '1',
      title: 'Interstellar',
      synopsis: 'A science fiction movie.',
      ageRating: '12A',
      runtime: '169 minutes',
      screeningTime: '18:30',
      ticketPrice: 10.00,
      posterImage: '',
    );

    BasketRepository().addToBasket(
      BasketItem(
        movie: movie,
        quantity: 2,
      ),
    );

    await tester.runAsync(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      await tester.pumpAndSettle();

      final Database db = await CinemaDatabase.instance.database;

      await db.execute('DROP TABLE bookings');

      await tester.tap(find.text('BUY TICKETS'));
      await tester.pumpAndSettle();
    });

    await tester.pump();

    expect(BasketRepository().basketItems.length, 1);
    expect(BasketRepository().basketItems.first.quantity, 2);
    expect(BasketRepository().totalDue, 24.00);

    expect(find.text('Interstellar'), findsOneWidget);

    expect(
      find.text('Unable to save booking. Please try again.'),
      findsOneWidget,
    );

    expect(find.text('Your basket is empty'), findsNothing);
  });
}
