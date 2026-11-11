import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('SettingsView displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));

    // Verify that the SettingsView is displayed
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Address'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Patron Number'), findsOneWidget);
    expect(find.text('Receive news by email'), findsOneWidget);
    expect(find.text('Customer Profile'), findsOneWidget);
    expect(find.text('SAVE SETTINGS'), findsOneWidget);
    expect(find.text('CANCEL'), findsOneWidget);
  });
}
