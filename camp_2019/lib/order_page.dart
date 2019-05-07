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
          child: new Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Amount (in g)'),
              ),
              Text('Flavour:'),
              createFlavourRadioButton(Flavours.Salty),
              createFlavourRadioButton(Flavours.Sweet),
              createFlavourRadioButton(Flavours.Caramel),
              createFlavourRadioButton(Flavours.Wasabi),
            ],
          ),
          padding: EdgeInsets.all(5),
        ));
  }
}

enum Flavours { Salty, Sweet, Caramel, Wasabi }
