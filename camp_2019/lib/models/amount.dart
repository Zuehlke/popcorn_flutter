class Amount {
  int _value;

  Amount(this._value) {}

  static bool isValid(int amount) => amount >= minValue && amount <= maxValue;

  static final int minValue = 5;
  static final int maxValue = 500;
}
