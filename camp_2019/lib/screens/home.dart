import 'dart:async';
import 'package:PopcornMaker/api/client.dart';
import 'package:PopcornMaker/models/machine.dart';
import 'package:PopcornMaker/models/order.dart';
import 'package:PopcornMaker/models/order_status.dart';
import 'package:PopcornMaker/screens/order_create.dart';
import 'package:PopcornMaker/screens/order_details.dart';
import 'package:PopcornMaker/screens/settings.dart';
import 'package:PopcornMaker/user_name_registry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _machines = new List<Machine>();
  Machine _selectedMachine;
  var _orders = new List<Order>();

  final TextStyle smallTextStyle = new TextStyle(fontSize: 16);

  @override
  void initState() {
    super.initState();

    Client()
        .getAllMachines()
        .then((machines) => setState(() {
              _machines = machines;
              _selectedMachine = _machines[0];
            }))
        .then((t) => refreshOrders());

    Observable.periodic(Duration(seconds: 5)).listen((_) => refreshOrders());
  }

  Future<void> refreshOrders() {
    if (_selectedMachine == null) {
      return Completer().future;
    }

    return Client().getOrders(_selectedMachine.id).then((newOrders) => {
          setState(() => {_orders = newOrders})
        });
  }

  @override
  Widget build(BuildContext context) {
    final borderSide =
        BorderSide(color: Colors.grey, width: 1.0, style: BorderStyle.solid);
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
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage(UserNameRegistry()))),
              color: Colors.white,
            ),
          ],
        ),
        body: buildBody(borderSide));
  }

  Widget buildBody(BorderSide borderSide) {
    if (_machines.isEmpty) {
      return Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text("Preparing . . . "),
          )
        ],
      ));
    }

    const defaultPadding = 6.0;
    const defaultCornerRadius = 8.0;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // Machine status
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                border: Border(
                    top: borderSide,
                    right: borderSide,
                    left: borderSide,
                    bottom: borderSide),
                borderRadius:
                    BorderRadius.all(Radius.circular(defaultCornerRadius))),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder(horizontalInside: borderSide),
              children: [
                TableRow(children: [
                  Text("Machine State"),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Text(describeEnum(_selectedMachine.status),
                        style: smallTextStyle),
                  )
                ]),
                TableRow(children: [
                  Text("Corn Level"),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Text(_selectedMachine.level.toString(),
                        style: smallTextStyle),
                  )
                ]),
                TableRow(children: [
                  Text("Flavours"),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Text(
                        _selectedMachine.flavours.map(describeEnum).join(","),
                        style: smallTextStyle),
                  )
                ])
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
                  border: Border(
                      top: borderSide,
                      right: borderSide,
                      left: borderSide,
                      bottom: borderSide),
                  borderRadius:
                      BorderRadius.all(Radius.circular(defaultCornerRadius))),
              child: buildOrderList(),
            ),
          ),
          buildNavigationalButton("Order Popcorn",
              (context) => OrderCreatePage(_selectedMachine.id)),
        ]),
      ),
    );
  }

  Widget buildOrderList() {
    if (_orders.isEmpty) {
      return Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text("Fetching Orders . . ."),
          )
        ],
      ));
    }

    return Scrollbar(
      child: ListView.builder(
        padding: EdgeInsets.all(6),
        itemCount: _orders.length,
        itemBuilder: (context, i) {
          var order = _orders[i];
          IconData icon;
          switch (order.status) {
            case OrderStatus.Undefined:
              icon = Icons.highlight_off;
              break;
            case OrderStatus.InQueue:
              icon = Icons.access_time;
              break;
            case OrderStatus.InProgress:
              icon = Icons.autorenew;
              break;
            case OrderStatus.Complete:
              icon = Icons.check_circle_outline;
              break;
            case OrderStatus.AwaitingPayment:
              icon = Icons.monetization_on;
              break;
          }
          return Card(
            child: ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderDetailsPage(_orders[i]))),
              leading: Image(
                image: AssetImage('assets/popcorn_purple.png'),
                height: 40,
              ),
              trailing: Icon(icon),
              title: Text(
                "${describeEnum(order.flavour)} popcorn for ${order.userName}",
                style: smallTextStyle,
              ),
            ),
          );
        },
      ),
    );
  }

  RaisedButton buildNavigationalButton(String buttonText,
      StatefulWidget destinationBuilder(BuildContext context)) {
    return RaisedButton(
      key: Key(buttonText.replaceAll(' ', '')),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.purple,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: destinationBuilder),
        );
      },
    );
  }
}
