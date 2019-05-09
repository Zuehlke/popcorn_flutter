class Amount {
  static bool isValid(int amount) => amount >= minValue && amount <= maxValue;
  static final int minValue = 1;
  static final int maxValue = 4;
}
