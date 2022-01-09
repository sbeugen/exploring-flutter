// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pokemon_test_app/main.dart';
import 'package:pokemon_test_app/persistence/pokemon_database_connector.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      pokemonDatabaseConnector: PokemonDatabaseConnector(),
    ));

    // Verify that on initial load you are prompted to clicked on randomize
    expect(find.text('Click on randomize'), findsOneWidget);
  });
}
