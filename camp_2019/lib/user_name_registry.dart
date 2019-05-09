import 'package:shared_preferences/shared_preferences.dart';

class UserNameRegistry {
  final _userNamePrefKey = "userName";

  static final UserNameRegistry _instance = UserNameRegistry._internal();

  factory UserNameRegistry() {
    return _instance;
  }

  UserNameRegistry._internal();

  Future<String> getCurrent() async {
    var preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey(_userNamePrefKey)) {
      return preferences.get(_userNamePrefKey);
    }

    return '';
  }

  Future<void> setCurrent(String value) async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setString(_userNamePrefKey, value);
  }
}
