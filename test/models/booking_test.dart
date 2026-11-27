import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/booking.dart';

void main() {
  const Booking booking = Booking(
    bookingNumber: 1004,
    summary: '2 x Interstellar',
    total: 20.00,
    date: '01/01/2026 09:05',
  );

  test('New bookings omit database ids and convert to map', () {
    expect(booking.id, isNull);

    expect(booking.toMap(), <String, Object?>{
      'booking_number': 1004,
      'summary': '2 x Interstellar',
      'total': 20.00,
      'date': '01/01/2026 09:05',
    });
  });

  test('Booking can be created from a database map', () {
    final Map<String, Object?> map = <String, Object?>{
      'id': 7,
      'booking_number': 1010,
      'summary': '1 x Interstellar',
      'total': 10.00,
      'date': '01/01/2026 10:30',
    };

    final Booking restored = Booking.fromMap(map);

    expect(restored.id, 7);
    expect(restored.bookingNumber, 1010);
    expect(restored.summary, '1 x Interstellar');
    expect(restored.total, 10.00);
    expect(restored.date, '01/01/2026 10:30');

    expect(restored.toMap(), map);
  });

  test('Whole-number database totals are converted to doubles', () {
    final Map<String, Object?> map = <String, Object?>{
      'id': 8,
      'booking_number': 1011,
      'summary': '1 x Interstellar',
      'total': 10,
      'date': '01/01/2026 11:30',
    };

    final Booking restored = Booking.fromMap(map);

    expect(restored.total, 10.0);
    expect(restored.total, isA<double>());
  });
}
