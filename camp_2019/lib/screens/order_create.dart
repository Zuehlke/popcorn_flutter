import 'package:camp_2019/models/amount.dart';
import 'package:camp_2019/models/flavour.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class OrderCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderCreatePageState();
}

class _OrderCreatePageState extends State<OrderCreatePage> {
  Flavour _selectedFlavour = Flavour.Salty;
  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount (in g)'),
                keyboardType: TextInputType.number,
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
                    padding: EdgeInsets.all(15),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
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
}
