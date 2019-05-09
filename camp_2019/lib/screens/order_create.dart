import 'package:camp_2019/api/client.dart';
import 'package:camp_2019/models/amount.dart';
import 'package:camp_2019/models/flavour.dart';
import 'package:camp_2019/models/order_request.dart';
import 'package:camp_2019/user_name_registry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderCreatePage extends StatefulWidget {
  String _machineId;

  OrderCreatePage(this._machineId);

  @override
  State<StatefulWidget> createState() => _OrderCreatePageState(_machineId);
}

class _OrderCreatePageState extends State<OrderCreatePage> {
  String _machineId;
  Flavour _flavour = Flavour.Salty;
  bool _isBusy = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();

  _OrderCreatePageState(this._machineId);

  RadioListTile<Flavour> createFlavourRadioButton(Flavour flavour) {
    var result = RadioListTile<Flavour>(
      title: Text(describeEnum(flavour)),
      value: flavour,
      groupValue: _flavour,
      onChanged: (Flavour value) {
        setState(() {
          _flavour = value;
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
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount (in g)'),
                keyboardType: TextInputType.number,
                controller: _amountController,
                validator: (String text) {
                  var num = int.tryParse(text);
                  if (num == null || Amount.isValid(num)) {
                    return null;
                  }

                  return "Incorrect value (should be between ${Amount.minValue} and ${Amount.maxValue})";
                },
              ),
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
                onPressed: _isBusy
                    ? null
                    : () {
                        if (_formKey.currentState.validate()) {
                          createOrder(context);
                        }
                      },
                child: Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createOrder(BuildContext context) async {
    var userName = await UserNameRegistry().getCurrent();
    var amount = int.tryParse(_amountController.text) ?? 0;
    var orderRequest = OrderRequest(_machineId, userName, amount, _flavour);
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
}
