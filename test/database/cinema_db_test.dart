import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  Booking makeBooking(int bookingNumber) {
    return Booking(
      bookingNumber: bookingNumber,
      summary: '2 x Interstellar',
      total: 20.00,
      date: '27/11/2026 15:30',
    );
  }

  setUp(() async {
    sqfliteFfiInit();

    final Database database = await databaseFactoryFfiNoIsolate.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: CinemaDatabase.instance.createTables,
      ),
    );

    CinemaDatabase.instance.setDatabase(database);
  });

  tearDown(() async {
    await CinemaDatabase.instance.close();
  });

  test('Booking can be inserted and retrieved', () async {
    final Booking booking = makeBooking(1001);

    final int id = await CinemaDatabase.instance.insertBooking(booking);

    expect(id, greaterThan(0));

    final List<Booking> bookings =
        await CinemaDatabase.instance.getAllBookings();

    expect(bookings.length, 1);
    expect(bookings.first.id, id);
    expect(bookings.first.bookingNumber, 1001);
    expect(bookings.first.summary, booking.summary);
    expect(bookings.first.total, booking.total);
    expect(bookings.first.date, booking.date);
  });

  test('Next booking number starts at 1001 and increments', () async {
    expect(
      await CinemaDatabase.instance.getNextBookingNumber(),
      1001,
    );

    await CinemaDatabase.instance.insertBooking(makeBooking(1005));

    expect(
      await CinemaDatabase.instance.getNextBookingNumber(),
      1006,
    );
  });

  test('Bookings are returned in descending booking number order', () async {
    await CinemaDatabase.instance.insertBooking(makeBooking(1001));
    await CinemaDatabase.instance.insertBooking(makeBooking(1003));
    await CinemaDatabase.instance.insertBooking(makeBooking(1002));

    final List<Booking> bookings =
        await CinemaDatabase.instance.getAllBookings();

    expect(bookings.length, 3);
    expect(bookings[0].bookingNumber, 1003);
    expect(bookings[1].bookingNumber, 1002);
    expect(bookings[2].bookingNumber, 1001);
  });
}
