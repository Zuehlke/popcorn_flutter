import 'package:camp_2019/order_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new OrderDetailsPageState();
  }
}

class OrderDetailsPageState extends State<OrderDetailsPage> {
  Order _order;
  List<OrderDetailsItem> _items;

  OrderDetailsPageState() {
    _order = new Order(
        'Hans', 5, Flavours.Sweet, Status.InProgress, DateTime.now());

    _items = [
      new OrderDetailsItem("Name", _order.userName),
      new OrderDetailsItem("Amount (g)", _order.amount.toString()),
      new OrderDetailsItem("Falvour", describeEnum(_order.flavour)),
      new OrderDetailsItem("Status", describeEnum(_order.status)),
      new OrderDetailsItem("Pickup Time", new DateFormat("dd.MM.yyyy HH:mm").format(_order.pickupTime)),
    ];

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Order Popcorn'),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: ListView.separated(
            itemCount: _items.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text('${_items[index].value}'),
                trailing: Text('${_items[index].name}'),
              );
            },
          ),
        ));
  }
}

class OrderDetailsItem {
  String name;
  String value;

  OrderDetailsItem(this.value, this.name);
}

class Order {
  Order(this.userName, this.amount, this.flavour, this.status, this.pickupTime);

  String userName;
  int amount;
  Flavours flavour;
  Status status;
  DateTime pickupTime;
}

enum Status { InQueue, InProgress }
