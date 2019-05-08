import 'package:camp_2019/order_page.dart';
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
      home: MyHomePage(title: 'Popcorn Maker'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: true,
        ),
        body: Center(
          child: Column(children: [
            RaisedButton(
              child: Text("Spike"),
              onPressed: () => {},
            ),
            RaisedButton(
              child: Text("Main"),
              onPressed: () => {},
            ),
            buildNavigationalButton("Order", (context) => OrderPage()),
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
