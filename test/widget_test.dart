import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:southsea_cinema/views/settings_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    rootBundle.evict('assets/data/movies.json');
    BasketRepository().clearBasket();

    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  Future<void> loadMovies(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1000, 2000);
    tester.view.devicePixelRatio = 1;

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SouthseaCinemaApp());

    await tester.runAsync(() async {
      await Future<void>.delayed(
        const Duration(milliseconds: 100),
      );
    });

    await tester.pumpAndSettle();

    expect(find.byType(MovieCard), findsNWidgets(2));
  }

  Future<void> openInterstellar(WidgetTester tester) async {
    await loadMovies(tester);

    await tester.tap(find.text('Book Now').first);
    await tester.pumpAndSettle();

    expect(find.byType(MovieListing), findsOneWidget);
  }

  group('Southsea Cinema widget tests', () {
    testWidgets(
      'App displays HomeView',
      (WidgetTester tester) async {
        await tester.pumpWidget(const SouthseaCinemaApp());

        expect(find.byType(HomeView), findsOneWidget);
        expect(find.text(appTitle), findsOneWidget);
      },
    );

    testWidgets('App displays movie cards and booking buttons',
        (WidgetTester tester) async {
      await loadMovies(tester);

      expect(find.text('Interstellar'), findsOneWidget);
      expect(
        find.text('Wolf of Wall Street'),
        findsOneWidget,
      );
      expect(find.text('Book Now'), findsNWidgets(2));
    });

    testWidgets('Book Now opens the correct movie',
        (WidgetTester tester) async {
      await openInterstellar(tester);

      expect(
        find.text('Interstellar (12A)'),
        findsOneWidget,
      );

      expect(
        find.text('Screening Time: 18:00'),
        findsOneWidget,
      );
    });

    testWidgets('Add to Order requires at least one ticket',
        (WidgetTester tester) async {
      await openInterstellar(tester);

      await tester.ensureVisible(
        find.text('Add to Order'),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add to Order'));
      await tester.pump();

      expect(
        find.text('Please select at least one ticket'),
        findsOneWidget,
      );
    });

    testWidgets('Selecting two tickets adds them to the order',
        (WidgetTester tester) async {
      await openInterstellar(tester);

      await tester.ensureVisible(
        find.byType(DropdownMenu<int>),
      );
      await tester.pumpAndSettle();

      await tester.tap(
        find.byType(DropdownMenu<int>),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(
        find.text('Add to Order'),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add to Order'));
      await tester.pump();

      expect(
        find.text(
          '2 tickets added to your order for Interstellar',
        ),
        findsOneWidget,
      );

      final basketItems = BasketRepository().basketItems;

      expect(basketItems.length, 1);
      expect(basketItems[0].quantity, 2);
      expect(
        basketItems[0].movie.title,
        'Interstellar',
      );
      expect(basketItems[0].totalPrice, 20.0);

      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);

      await tester.tap(
        find.byTooltip('Open navigation menu'),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Basket'));
      await tester.pumpAndSettle();

      expect(find.byType(BasketView), findsOneWidget);

      expect(
        find.textContaining('Interstellar'),
        findsWidgets,
      );
    });

    testWidgets('Removing a movie clears it from the basket',
        (WidgetTester tester) async {
      await openInterstellar(tester);

      await tester.ensureVisible(find.byType(DropdownMenu<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownMenu<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Add to Order'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add to Order'));
      await tester.pump();

      expect(BasketRepository().basketItems.length, 1);

      await tester.pumpWidget(
        const MaterialApp(home: BasketView()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Interstellar'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(BasketRepository().basketItems, isEmpty);
      expect(find.text('Your basket is empty'), findsOneWidget);
    });

    testWidgets('Buying tickets clears the basket',
        (WidgetTester tester) async {
      await openInterstellar(tester);

      await tester.ensureVisible(find.byType(DropdownMenu<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownMenu<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Add to Order'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add to Order'));
      await tester.pump();

      expect(BasketRepository().basketItems.length, 1);
      expect(BasketRepository().basketItems[0].quantity, 2);

      await tester.pumpWidget(
        const MaterialApp(home: BasketView()),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('BUY TICKETS'));
      await tester.pumpAndSettle();

      expect(BasketRepository().basketItems, isEmpty);

      expect(
        find.text('Your basket is empty'),
        findsOneWidget,
      );

      expect(
        find.text('Thank you! Your tickets have been purchased.'),
        findsOneWidget,
      );
    });

    testWidgets('SettingsView loads saved preferences', (
      WidgetTester tester,
    ) async {
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.withData(<String, Object>{
        'customerAddress': '25 High Street, Portsmouth',
        'customerEmail': 'test@example.com',
        'patronNumber': '12345',
        'emailNews': true,
      });

      await tester.pumpWidget(
        const MaterialApp(home: SettingsView()),
      );

      await tester.pumpAndSettle();
      expect(
        find.text('25 High Street, Portsmouth'),
        findsOneWidget,
      );

      expect(
        find.text('test@example.com'),
        findsOneWidget,
      );

      expect(
        find.text('12345'),
        findsOneWidget,
      );
      final Switch emailSwitch = tester.widget<Switch>(
        find.byType(Switch),
      );

      expect(emailSwitch.value, isTrue);
    });

    testWidgets('Saving edited settings updates preferences', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: SettingsView()),
      );

      await tester.pumpAndSettle();
      final addressField = find.byType(TextField).at(0);
      final emailField = find.byType(TextField).at(1);
      final patronNumberField = find.byType(TextField).at(2);

      await tester.enterText(
        addressField,
        'Guildhall, Portsmouth',
      );

      await tester.enterText(
        emailField,
        'student@example.com',
      );

      await tester.enterText(
        patronNumberField,
        '67890',
      );

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('SAVE SETTINGS'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('SAVE SETTINGS'));
      await tester.pumpAndSettle();

      expect(
        find.text('Settings saved successfully!'),
        findsOneWidget,
      );

      final SharedPreferencesAsync prefs = SharedPreferencesAsync();

      expect(
        await prefs.getString('customerAddress'),
        'Guildhall, Portsmouth',
      );

      expect(
        await prefs.getString('customerEmail'),
        'student@example.com',
      );

      expect(
        await prefs.getString('patronNumber'),
        '67890',
      );

      expect(
        await prefs.getBool('emailNews'),
        isTrue,
      );

      await tester.pumpWidget(
        const SizedBox.shrink(),
      );
      await tester.pumpWidget(
        const MaterialApp(home: SettingsView()),
      );

      await tester.pumpAndSettle();

      expect(
        find.text('Guildhall, Portsmouth'),
        findsOneWidget,
      );

      expect(
        find.text('student@example.com'),
        findsOneWidget,
      );

      expect(
        find.text('67890'),
        findsOneWidget,
      );
    });
  });
}
