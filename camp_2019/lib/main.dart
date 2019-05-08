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
      home: MainPage(title: 'Popcorn Maker'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState(
      ["mid: 01", "mid: 02", "mid: 03"], ["O1", "O2", "O3", "O1", "O2", "O3", "O1", "O2", "O3", "O1", "O2", "O3", "O1", "O2", "O3", "O1", "O2", "O3"]);
}

class _MainPageState extends State<MainPage> {
  final _biggerFont = const TextStyle(fontSize: 18);

  final List<String> _machines;
  final List<String> _orders;
  String selectedMachine;

  _MainPageState(this._machines, this._orders) : super() {
    selectedMachine = _machines[0];
  }

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: Colors.grey, width: 1.0, style: BorderStyle.solid);
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
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage())),
              color: Colors.white,
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              // Machine dropdown

              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                child: DropdownButton<String>(
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
              ),

              // Machine status
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder(bottom: borderSide, top: borderSide, left: borderSide, right: borderSide, horizontalInside: borderSide),
                  children: [
                    TableRow(children: [Text("Machine State"), Text("BUSY")]),
                    TableRow(children: [Text("Corn Level"), Text("81%")]),
                    TableRow(children: [Text("Flavours"), Text("SWEET, SALTY, CARAMEL, WASABI")])
                  ],
                ),
              ),

              // Machine Order Queue
              Align(
                heightFactor: 1.5,
                child: Text(
                  "Queue",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.bottomLeft,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      border: Border(top: borderSide, right: borderSide, left: borderSide, bottom: borderSide),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Scrollbar(
                    child: ListView.separated(
                      padding: EdgeInsets.all(6),
                      itemCount: _orders.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, i) {
                        return Text(
                          _orders[i],
                          style: _biggerFont,
                        );
                      },
                    ),
                  ),
                ),
              ),

                        RaisedButton(
              child: Text("Spike"),
              onPressed: () => {
                    setState(() => {
                          Spike.sendRequest(
                                  'cb60b9f71f18496a8d0574c9d705963f')
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
            buildNavigationalButton("Order", (context) => OrderPage()),
            buildNavigationalButton("Order details", (context) => OrderDetailsPage()),
            buildNavigationalButton("Settings", (context) => SettingsPage()),
            ]),
          ),
        ));
  }

  RaisedButton buildNavigationalButton(String buttonText, StatefulWidget destinationBuilder(BuildContext context)) {
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
      throw response.reasonPhrase;
    }

    var responseJson = json.decode(response.body);
    return responseJson['id'] as String;
  }
}
