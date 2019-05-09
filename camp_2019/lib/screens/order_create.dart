import 'package:PopcornMaker/api/client.dart';
import 'package:PopcornMaker/models/amount.dart';
import 'package:PopcornMaker/models/flavour.dart';
import 'package:PopcornMaker/models/order_request.dart';
import 'package:PopcornMaker/user_name_registry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class OrderCreatePage extends StatefulWidget {
  final String _machineId;

  OrderCreatePage(this._machineId);

  @override
  State<StatefulWidget> createState() => _OrderCreatePageState(_machineId);
}

class _OrderCreatePageState extends State<OrderCreatePage> {
  String _machineId;
  Flavour _flavour = Flavour.Salty;
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
                key: Key('Amount'),
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
              DateTimePickerFormField(
                format: DateFormat("dd.MM.yyyy HH:mm"),
                inputType: InputType.both,
                decoration: InputDecoration(hintText: "PickupTime"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    key: Key('submit'),
                    padding: EdgeInsets.all(15),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        createOrder();
                      }
                    },
                    child: Text('Submit Order'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createOrder() {
    UserNameRegistry().getCurrent().then((userName) {
      var amount = int.tryParse(_amountController.text) ?? 0;
      var orderRequest = OrderRequest(_machineId, userName, amount, _flavour);
      Client().createOrder(orderRequest);
    });
  }
}
