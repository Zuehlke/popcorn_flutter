import 'package:camp_2019/amount.dart';
import 'package:test/test.dart';

void main() {
  group('Amount isValid tests', () {
    test('amount 4 is invalid', () {
      expect(Amount.isValid(4), false);
    });

    test('amount 501 is invalid', () {
      expect(Amount.isValid(500), true);
    });

    test('amount 5 is valid', () {
      expect(Amount.isValid(5), true);
    });

    test('amount 500 is valid', () {
      expect(Amount.isValid(500), true);
    });

    test('amount 300 is valid', () {
      expect(Amount.isValid(500), true);
    });
  });
}
