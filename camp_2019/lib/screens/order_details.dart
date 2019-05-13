import 'package:PopcornMaker/api/client.dart';
import 'package:PopcornMaker/models/order.dart';
import 'package:PopcornMaker/models/order_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatefulWidget {
  Order order;

  OrderDetailsPage(this.order) {}

  @override
  State<StatefulWidget> createState() {
    return DetailState(this.order);
  }
}

class DetailState extends State<OrderDetailsPage> {
  final List<OrderDetailsItem> _items = List<OrderDetailsItem>();
  Order order;

  String link = null;

  DetailState(this.order) {
    _items.add(OrderDetailsItem("Name", order.userName));
    _items.add(OrderDetailsItem("Serving Size", describeEnum(order.size)));
    _items.add(OrderDetailsItem("Flavour", describeEnum(order.flavour)));
    _items.add(OrderDetailsItem("Status", describeEnum(order.status)));
    if (order.status == OrderStatus.AwaitingPayment) {
      Client().getPayLink(order).then((link) => setState(() {
            this.link = link;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.link == null) {
      return new Scaffold(
          appBar: new AppBar(
            title: Text('Order Popcorn'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: <Widget>[
              buildContainer(),
            ]),
          ));
    } else {
      return new Scaffold(
          appBar: new AppBar(
            title: Text('Order Popcorn'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                buildContainer(),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                        "To pay for your order, please use the following barcode:")),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.network(
                        "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" +
                            link))
              ],
            ),
          ));
    }
  }

  Container buildContainer() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.all(Radius.circular(15))),
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
    );
  }
}

class OrderDetailsItem {
  String name;
  String value;

  OrderDetailsItem(this.value, this.name);
}
