import 'dart:convert';

import 'package:camp_2019/order_details_page.dart';
import 'package:camp_2019/order_page.dart';
import 'package:camp_2019/screens/settings.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

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
              onPressed: () => {
                    setState(() => {
                          Spike.sendRequest(
                                  'E63D8231-CDAA-44E2-8B7F-A388EF2BAB53')
                              .then((String orderId) => {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Successfully sent request and received back orderId " +
                                                orderId.toString(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIos: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0)
                                  })
                              .catchError((error) => {
                                    Fluttertoast.showToast(
                                        msg: error.toString(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIos: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0)
                                  })
                        })
                  },
            ),
            RaisedButton(
              child: Text("Main"),
              onPressed: () => {setState(() => {})},
            ),
            buildNavigationalButton("Order", (context) => OrderPage()),
            buildNavigationalButton(
                "Order details", (context) => OrderDetailsPage()),
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

class Spike {
  static Future<String> sendRequest(String machineId) async {
    var data = {"userName": "FlutterSpike", "amount": 100, "flavour": "SWEET"};
    var url = 'https://popcornmakerbackend20190507022416.azurewebsites.net/api';
    url += '/machines/' + machineId + '/orders';
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.post(url, body: json.encode(data), headers: headers);

    final int statusCode = response.statusCode;

    if (statusCode != 200) {
      throw response.body;
    }

    var responseJson = json.decode(response.body);
    return responseJson['id'] as String;
  }
}
