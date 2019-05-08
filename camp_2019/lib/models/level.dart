class Level {
  int _value;

  Level(int from) {
    if (from < 0 || from > 100) throw from;

    _value = from;
  }

  int get value => _value;
}

Level parseLevel(String level) => Level(int.parse(level));