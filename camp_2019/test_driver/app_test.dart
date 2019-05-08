// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Popcorn Maker App', () {
    // First, define the Finders. We can use these to locate Widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('increment');

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
      final buttonFinder = find.byValueKey('Order');
      driver.tap(buttonFinder);

      final submitButtoFinder = find.byValueKey('submit');
      await driver.waitFor(submitButtoFinder);
    });

    // test('increments the counter', () async {
    //   // First, tap on the button
    //   await driver.tap(buttonFinder);

    //   // Then, verify the counter text has been incremented by 1
    //   expect(await driver.getText(counterTextFinder), "1");
    // });
  });
}
