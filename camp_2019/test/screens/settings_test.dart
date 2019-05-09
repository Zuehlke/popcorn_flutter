// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:camp_2019/screens/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('Settings page smoke test', (WidgetTester tester) async {
    final preferencesMock = MockPreferences();
    when(preferencesMock.containsKey('userName')).thenAnswer((_) => false);

    // Build our app and trigger a frame.
    await tester.pumpWidget(
        MaterialApp(home: SettingsPage(new Future(() => preferencesMock))));

    final textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder, 'Daniel Rosendorf');

    verify(preferencesMock.setString('userName', 'Daniel Rosendorf')).called(1);
  });
}

class MockPreferences extends Mock implements SharedPreferences {}
