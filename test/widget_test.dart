import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  group('Southsea Cinema widget tests', () {
    testWidgets('App displays HomeView', (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.byType(HomeView), findsOneWidget);
      expect(find.text(appTitle), findsOneWidget);
    });

    testWidgets('App displays movie cards and booking buttons',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1000, 2000);
      tester.view.devicePixelRatio = 1;

      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.byType(MovieCard), findsNWidgets(2));
      expect(find.text('Interstellar'), findsOneWidget);
      expect(find.text('The Wolf of Wall Street'), findsOneWidget);
      expect(find.text('Book Now'), findsNWidgets(2));
    });

    testWidgets('Book Now opens the correct movie',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.tap(find.text('Book Now').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('Interstellar (12A)'), findsOneWidget);
      expect(find.text('Screening Time: 18:00'), findsOneWidget);
    });

    testWidgets('Add to Order displays a confirmation message',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.tap(find.text('Book Now').first);
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Add to Order'));
      await tester.tap(find.text('Add to Order'));
      await tester.pump();

      expect(
        find.text('0 tickets added to your order for Interstellar'),
        findsOneWidget,
      );
    });
  });
}
