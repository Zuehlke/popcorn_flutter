import 'package:camp_2019/api/client.dart';
import 'package:camp_2019/screens/order_create.dart';
import 'package:camp_2019/screens/order_details.dart';
import 'package:camp_2019/screens/settings.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState(List<String>.generate(20, (it) => "01"));
}

class _HomePageState extends State<HomePage> {
  var _machines = new List<String>();
  List<String> _orders;
  String _selectedMachine;

  _HomePageState(this._orders) : super();

  @override
  void initState() {
    super.initState();

    var client = new Client();
    client.getAllMachines().then((machines) => setState(() {
          _machines = machines.map((machine) => machine.name).toList();
          _selectedMachine = _machines[0];
        }));
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
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage())),
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
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropdownButton<String>(
                      items: _machines.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) => {
                            setState(() {
                              _selectedMachine = newValue;
                            })
                          },
                      value: _selectedMachine,
                    ),
                  ),

                  // Machine status
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border: TableBorder(
                          bottom: borderSide,
                          top: borderSide,
                          left: borderSide,
                          right: borderSide,
                          horizontalInside: borderSide),
                      children: [
                        TableRow(
                            children: [Text("Machine State"), Text("BUSY")]),
                        TableRow(children: [Text("Corn Level"), Text("81%")]),
                        TableRow(children: [
                          Text("Flavours"),
                          Text("SWEET, SALTY, CARAMEL, WASABI")
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Scrollbar(
                        child: ListView.separated(
                          padding: EdgeInsets.all(6),
                          itemCount: _orders.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, i) {
                            return Text(
                              _orders[i],
                              style: TextStyle(fontSize: 18),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  buildNavigationalButton(
                      "Order", (context) => OrderCreatePage()),
                  buildNavigationalButton(
                      "Order details", (context) => OrderDetailsPage()),
                  buildNavigationalButton(
                      "Settings", (context) => SettingsPage()),
                ]),
          ),
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
