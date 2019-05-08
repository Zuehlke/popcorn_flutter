import 'package:camp_2019/screens/settings.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popcorn Maker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MainPage(title: 'Popcorn Maker'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState(["mid: 01", "mid: 02", "mid: 03"]);
}

class _MainPageState extends State<MainPage> {
  final List<String> _machines;
  String selectedMachine;

  _MainPageState(this._machines) : super()
  {
    selectedMachine = _machines[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
          automaticallyImplyLeading: true,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
              color: Colors.white,
            ),
          ],
        ),
        body: Center(
          child: Column(children: [
            DropdownButton<String>(
                items: _machines.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) => {
                  setState(() {
                    selectedMachine = newValue;
                  })
            },
            value: selectedMachine,
            ),
            RaisedButton(
              child: Text("Spike"),
              onPressed: () => {},
            ),
            RaisedButton(
              child: Text("Order"),
              onPressed: () => {},
            ),
            RaisedButton(
              child: Text("OrderDetails"),
              onPressed: () => {},
            ),
            buildNavigationalButton("Settings", (context) => SettingsPage()),
          ]),
        ));
  }

  RaisedButton buildNavigationalButton(String buttonText,
      StatefulWidget destinationBuilder(BuildContext context)) {
    return RaisedButton(
      child: Text(buttonText),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: destinationBuilder),
        );
      },
    );
  }
}
