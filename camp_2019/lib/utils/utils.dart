class Utils {
  static DateTime parseDateTime(String date) {
    var fractionCharacterPosition = date.indexOf(".");
    var offsetCharacterPosition = date.indexOf("+");

    if (fractionCharacterPosition == -1) {
      return DateTime.parse(date);
    }

    if (offsetCharacterPosition == -1) {
      return DateTime.parse(
          date.substring(fractionCharacterPosition + 1).substring(0, 6));
    }

    return DateTime.parse(date
        .substring(fractionCharacterPosition + 1, offsetCharacterPosition)
        .substring(0, 6));

    // see https://stackoverflow.com/questions/52789217/flutter-parsing-json-with-datetime-from-golang-rfc3339-formatexception-invalid
    // basically dart can't handle more than 6 fraction digits but the specification says 7
  }
}
