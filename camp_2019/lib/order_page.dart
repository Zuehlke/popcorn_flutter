import 'package:camp_2019/amount.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new OrderPageState();
  }
}

class OrderPageState extends State<OrderPage> {
  Flavours _selectedFlavour;
  final _formKey = GlobalKey<FormState>();

  RadioListTile<Flavours> createFlavourRadioButton(Flavours flavourValue) {
    var flavourString = flavourValue.toString();
    flavourString = flavourString.substring(flavourString.indexOf('.') + 1);

    return RadioListTile<Flavours>(
      title: Text(flavourString),
      value: flavourValue,
      groupValue: _selectedFlavour,
      onChanged: (Flavours value) {
        setState(() {
          _selectedFlavour = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Order Popcorn'),
        ),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: Form(
            autovalidate: true,
            key: _formKey,
            child: Column(
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
                Text('Flavour:'),
                createFlavourRadioButton(Flavours.Salty),
                createFlavourRadioButton(Flavours.Sweet),
                createFlavourRadioButton(Flavours.Caramel),
                createFlavourRadioButton(Flavours.Wasabi),
              ],
            ),
          ),
        ));
  }
}

enum Flavours { Salty, Sweet, Caramel, Wasabi }
