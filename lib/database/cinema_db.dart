import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:southsea_cinema/models/booking.dart';

class CinemaDatabase {
  CinemaDatabase._internal();

  static final CinemaDatabase instance = CinemaDatabase._internal();

  static Database? _database;

  void setDatabase(Database? db) {
    _database = db;
  }

  Future<Database> get database async {
    final Database? cachedDatabase = _database;

    if (cachedDatabase != null) {
      return cachedDatabase;
    }

    final Database db = await _initDB('cinema_data.db');
    _database = db;

    return db;
  }

  Future<Database> _initDB(String fileName) async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS bookings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        booking_number INTEGER NOT NULL,
        summary TEXT NOT NULL,
        total REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<void> _createDB(Database db, int version) async {
    await createTables(db, version);

    await db.insert('bookings', <String, Object?>{
      'booking_number': 1003,
      'summary': '2 x Interstellar',
      'total': 20.00,
      'date': '25/11/2026 18:30',
    });

    await db.insert('bookings', <String, Object?>{
      'booking_number': 1002,
      'summary': '1 x Inception',
      'total': 10.00,
      'date': '24/11/2026 17:15',
    });

    await db.insert('bookings', <String, Object?>{
      'booking_number': 1001,
      'summary': '3 x Interstellar',
      'total': 30.00,
      'date': '23/11/2026 20:00',
    });
  }

  Future<int> insertBooking(Booking booking) async {
    final Database db = await database;

    return await db.insert('bookings', booking.toMap());
  }

  Future<List<Booking>> getAllBookings() async {
    final Database db = await database;

    final List<Map<String, Object?>> rows = await db.query(
      'bookings',
      orderBy: 'booking_number DESC',
    );

    final List<Booking> bookings = [];

    for (final Map<String, Object?> row in rows) {
      bookings.add(Booking.fromMap(row));
    }

    return bookings;
  }

  Future<int> getNextBookingNumber() async {
    final Database db = await database;

    final List<Map<String, Object?>> result = await db.rawQuery(
      'SELECT MAX(booking_number) AS max_num FROM bookings',
    );

    final Object? maxNumber = result.first['max_num'];

    if (maxNumber == null) {
      return 1001;
    }

    return (maxNumber as int) + 1;
  }

  Future<void> close() async {
    final Database? db = _database;

    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
