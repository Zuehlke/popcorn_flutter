import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _userNamePrefKey = "userName";
  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((preferences) {
      if (preferences.containsKey(_userNamePrefKey)) {
        _usernameController.text = preferences.get(_userNamePrefKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Text("Name"),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Please enter your "
                          "name"),
                  maxLines: 1,
                  onChanged: (newText) {
                    SharedPreferences.getInstance().then((preferences) {
                      preferences.setString(_userNamePrefKey, newText);
                    });
                  },
                  controller: _usernameController,
                )
              ],
            )));
  }
}
