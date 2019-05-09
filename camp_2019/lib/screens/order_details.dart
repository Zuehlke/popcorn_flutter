import 'package:PopcornMaker/models/order.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatelessWidget {
  final List<OrderDetailsItem> _items = List<OrderDetailsItem>();

  OrderDetailsPage(Order order) {
    _items.add(OrderDetailsItem("Name", order.userName));
    _items.add(OrderDetailsItem("Serving Size", describeEnum(order.size)));
    _items.add(OrderDetailsItem("Flavour", describeEnum(order.flavour)));
    _items.add(OrderDetailsItem("Status", describeEnum(order.status)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Order Popcorn'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: ListView.separated(
                  itemCount: _items.length,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text('${_items[index].value}'),
                      trailing: Text('${_items[index].name}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class OrderDetailsItem {
  String name;
  String value;

  OrderDetailsItem(this.value, this.name);
}
