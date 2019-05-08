
import 'package:camp_2019/models/flavour.dart';
import 'package:camp_2019/models/order_status.dart';

class Order {
  Order(this.userName, this.amount, this.flavour, this.status, this.pickupTime);

  String userName;
  int amount;
  Flavour flavour;
  OrderStatus status;
  DateTime pickupTime;
}