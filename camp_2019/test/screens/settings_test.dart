// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:PopcornMaker/user_name_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:PopcornMaker/screens/settings.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('Settings page smoke test', (WidgetTester tester) async {
    final userNameRegistryMock = UserNameRegistryMock();
    when(userNameRegistryMock.getCurrent()).thenAnswer((_) => Future(() => ''));

    // Build our app and trigger a frame.
    await tester
        .pumpWidget(MaterialApp(home: SettingsPage(userNameRegistryMock)));

    final textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder, 'Daniel Rosendorf');

    verify(userNameRegistryMock.setCurrent('Daniel Rosendorf')).called(1);
  });
}

class UserNameRegistryMock extends Mock implements UserNameRegistry {}
