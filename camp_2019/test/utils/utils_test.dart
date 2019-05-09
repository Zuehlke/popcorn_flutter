import 'package:PopcornMaker/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Utils parseDateTime', () {
    test('parse null value', () {
      final result = Utils.parseDateTime(null);

      expect(result, null);
    });

    test('parse valid value with TZ offset', () {
      final result = Utils.parseDateTime('2019-05-09T12:14:46.6716303+00:00');

      expect(result.day, 9);
      expect(result.month, 5);
      expect(result.year, 2019);
      expect(result.hour, 12);
      expect(result.minute, 14);
      expect(result.year, 2019);
    });

    test('parse valid value without TZ offset', () {
      final result = Utils.parseDateTime('2019-05-09T12:14:46.6716303');

      expect(result.day, 9);
      expect(result.month, 5);
      expect(result.year, 2019);
      expect(result.hour, 12);
      expect(result.minute, 14);
      expect(result.year, 2019);
    });

    test('parse valid value without TZ offset', () {
      final result = Utils.parseDateTime('2019-05-09T12:14:46');

      expect(result.day, 9);
      expect(result.month, 5);
      expect(result.year, 2019);
      expect(result.hour, 12);
      expect(result.minute, 14);
      expect(result.year, 2019);
    });
  });
}
