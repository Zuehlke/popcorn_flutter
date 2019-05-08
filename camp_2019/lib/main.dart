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
