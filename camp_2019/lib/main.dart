import 'dart:convert';

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
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Column(children: [
            RaisedButton(
              child: Text("Spike"),
              onPressed: () => {
                    setState(() => {
                          Spike.sendRequest(42)
                              .then((int orderId) => {
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
            RaisedButton(
              child: Text("Order"),
              onPressed: () => {setState(() => {})},
            ),
            RaisedButton(
              child: Text("OrderDetails"),
              onPressed: () => {setState(() => {})},
            ),
            RaisedButton(
              child: Text("Settings"),
              onPressed: () => {setState(() => {})},
            ),
          ]),
        ));
  }
}

class Spike {
  static Future<int> sendRequest(int machineId) async {
    var data = {"userName": "FlutterSpike", "amount": 100, "flavour": "SWEET"};
    var url = 'https://popcornmakerbackend20190507022416.azurewebsites.net/api';
    url += '/machines/' + machineId.toString() + '/orders';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(url, body: json.encode(data), headers: headers);

    final int statusCode = response.statusCode;

    if (statusCode != 201) {
      throw response.body;
    }

    var responseJson = json.decode(response.body);
    return responseJson['orderId'] as int;
    // return int.parse(responseJson[orderId] as int);
  }
}
