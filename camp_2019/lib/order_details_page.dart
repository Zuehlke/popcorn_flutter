import 'package:camp_2019/order_page.dart';
import 'package:flutter/material.dart';

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
    _order =
    new Order('Hans', 5, Flavours.Sweet, Status.In_Progress, DateTime.now());

    _items = [
      new OrderDetailsItem("Name", _order.userName),
      new OrderDetailsItem("Amount (g)", _order.amount.toString()),
      new OrderDetailsItem("Falvour", _order.flavour.toString()),
      new OrderDetailsItem("Status", _order.status.toString()),
      new OrderDetailsItem("Pickup Time", _order.pickupTime.toString()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Order Popcorn'),
        ),
        body: ListView.separated(
          itemCount: _items.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text('${_items[index].name}'),
              trailing: Text('${_items[index].value}'),
            );
          },
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

enum Status { In_Queue, In_Progress }
