// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Popcorn Maker App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('navigates', () async {
      final buttonFinder = find.byValueKey('OrderPopcorn');
      driver.tap(buttonFinder);

      final submitButtonFinder = find.byValueKey('submit');
      await driver.waitFor(submitButtonFinder);

      final amountInputBox = find.byValueKey('Amount');
      await driver.tap(amountInputBox);
      await driver.enterText('1');

      await driver.tap(submitButtonFinder);
    });
  });
}
