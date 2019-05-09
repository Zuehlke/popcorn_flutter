import 'package:camp_2019/user_name_registry.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState(UserNameRegistry());
}

class _SettingsPageState extends State<SettingsPage> {
  UserNameRegistry _userNameRegistry;
  TextEditingController _userNameController = TextEditingController();

  _SettingsPageState(this._userNameRegistry);

  @override
  void initState() {
    super.initState();

    _userNameRegistry.getCurrent().then((value) {
        _userNameController.text = value;
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
                    _userNameRegistry.setCurrent(newText);
                  },
                  controller: _userNameController,
                )
              ],
            )));
  }
}
