class Utils {
  static DateTime parseDateTime(String date) {
    if (date == null) {
      return null;
    }

    var fractionCharacterPosition = date.indexOf(".");
    var offsetCharacterPosition = date.indexOf("+");
    var dateToParse;

    if (fractionCharacterPosition == -1) {
      dateToParse = date;
      return DateTime.parse(dateToParse);
    }

    if (offsetCharacterPosition == -1) {
      dateToParse = date.substring(0, fractionCharacterPosition + 1) +
          date.substring(fractionCharacterPosition + 1).substring(0, 6);
      return DateTime.parse(dateToParse);
    }

    dateToParse = date.substring(0, fractionCharacterPosition + 1) +
        date
            .substring(fractionCharacterPosition + 1, offsetCharacterPosition)
            .substring(0, 6) +
        date.substring(offsetCharacterPosition);
    return DateTime.parse(dateToParse);

    // see https://stackoverflow.com/questions/52789217/flutter-parsing-json-with-datetime-from-golang-rfc3339-formatexception-invalid
    // basically dart can't handle more than 6 fraction digits but the specification says 7
  }
}
