import 'package:PopcornMaker/api/client.dart';
import 'package:PopcornMaker/models/flavour.dart';
import 'package:PopcornMaker/models/order_request.dart';
import 'package:PopcornMaker/models/serving_size.dart';
import 'package:PopcornMaker/screens/settings.dart';
import 'package:PopcornMaker/user_name_registry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderCreatePage extends StatefulWidget {
  final String _machineId;

  OrderCreatePage(this._machineId);

  @override
  State<StatefulWidget> createState() => _OrderCreatePageState(_machineId);
}

class _OrderCreatePageState extends State<OrderCreatePage> {
  String _machineId;
  Flavour _selectedFlavour = Flavour.Salty;
  bool _isBusy = false;
  ServingSize _selectedServingSize;

  _OrderCreatePageState(this._machineId) {
    _selectedServingSize = ServingSize.Small;
  }

  RadioListTile<Flavour> createFlavourRadioButton(Flavour flavour) {
    var result = RadioListTile<Flavour>(
      title: Text(describeEnum(flavour)),
      value: flavour,
      groupValue: _selectedFlavour,
      onChanged: (Flavour value) {
        setState(() {
          _selectedFlavour = value;
        });
      },
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Order Popcorn'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton(
                isExpanded: true,
                value: _selectedServingSize,
                onChanged: (value) {
                  setState(() {
                    _selectedServingSize = value;
                  });
                },
                items: ServingSize.values.map((entry) {
                  return DropdownMenuItem<ServingSize>(value: entry, child: Text(describeEnum(entry)));
                }).toList()),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Flavour"),
              ),
            ),
            createFlavourRadioButton(Flavour.Salty),
            createFlavourRadioButton(Flavour.Sweet),
            createFlavourRadioButton(Flavour.Caramel),
            createFlavourRadioButton(Flavour.Wasabi),
            RaisedButton(
              color: Colors.purple,
              textColor: Colors.white,
              onPressed: _isBusy ? null : () => createOrder(context),
              child: Text('Submit Order'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createOrder(BuildContext context) async {
    var userName = await UserNameRegistry().getCurrent();

    if (userName == null || userName.isEmpty) {
      handleMissingUsername();
      return;
    }

    var orderRequest = OrderRequest(_machineId, userName, _selectedServingSize, _selectedFlavour);
    try {
      setState(() {
        _isBusy = true;
      });
      await Client().createOrder(orderRequest);
      navigateBack(context);
    } catch (ex) {
      showErrorToast();
    } finally {
      setState(() {
        _isBusy = false;
      });
    }
  }

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  void showErrorToast() {
    Fluttertoast.showToast(
        msg: "Something went wrong...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void handleMissingUsername() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("No Username"),
          content: new Text("You didn't choose a user name. Do you want to choose one?"),
          actions: <Widget>[

            // YES
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => SettingsPage(UserNameRegistry())));
              },
            ),

            // No
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
