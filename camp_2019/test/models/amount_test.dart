import 'package:camp_2019/models/amount.dart';
import 'package:test/test.dart';

void main() {
  group('Amount isValid tests', () {
    test('amount 0 is invalid', () {
      expect(Amount.isValid(0), false);
    });

    test('amount 5 is invalid', () {
      expect(Amount.isValid(5), false);
    });

    test('amount 1 is valid', () {
      expect(Amount.isValid(1), true);
    });

    test('amount 4 is valid', () {
      expect(Amount.isValid(4), true);
    });

    test('amount 2 is valid', () {
      expect(Amount.isValid(2), true);
    });
  });
}
