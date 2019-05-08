import 'package:camp_2019/models/amount.dart';
import 'package:camp_2019/models/flavours.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new OrderPageState();
  }
}

class OrderPageState extends State<OrderPage> {
  Flavours _selectedFlavour = Flavours.Salty;
  final _formKey = GlobalKey<FormState>();

  RadioListTile<Flavours> createFlavourRadioButton(Flavours flavour) {
    var result = RadioListTile<Flavours>(
      title: Text(describeEnum(flavour)),
      value: flavour,
      groupValue: _selectedFlavour,
      onChanged: (Flavours value) {
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
              createFlavourRadioButton(Flavours.Salty),
              createFlavourRadioButton(Flavours.Sweet),
              createFlavourRadioButton(Flavours.Caramel),
              createFlavourRadioButton(Flavours.Wasabi),
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