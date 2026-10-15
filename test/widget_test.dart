import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/constants.dart';

void main() {
  group('Southsea Cinema widget tests', () {
    testWidgets('App displays HomeView', (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      expect(find.byType(HomeView), findsOneWidget);
      expect(
        find.text(appTitle),
        findsOneWidget,
      );
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
  });
}
