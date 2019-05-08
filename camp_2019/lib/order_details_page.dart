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
  var _order =
      new Order('Hans', 5, Flavours.Sweet, Status.In_Progress, DateTime.now());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Order Popcorn'),
        ),
        body: ListView.separated(
          itemCount: 5,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('item $index'),
            );
          },
        ));
  }
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
