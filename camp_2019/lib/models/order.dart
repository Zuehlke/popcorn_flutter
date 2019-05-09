
import 'package:PopcornMaker/models/flavour.dart';
import 'package:PopcornMaker/models/order_status.dart';
import 'package:PopcornMaker/utils/utils.dart';

class Order {
  Order(this.id, this.machineId, this.userName, this.amount, this.flavour, this.status, this.pickupTime);

  String id;
  String machineId;
  String userName;
  int amount;
  Flavour flavour;
  OrderStatus status;
  DateTime pickupTime;
}


Order parseOrder(dynamic json) {
  var id = json['id'];
  var machineId = json['machineId'];
  var userName = json['userName'];
  var amount = json['amount'];
  var flavour = parseFlavour(json['flavour']);
  var pickupTime = Utils.parseDateTime(json['pickupTime']);
  var status = parseOrderStatus(json['status']);

  return Order(id, machineId, userName, amount, flavour, status, pickupTime);
}

List<Order> parseOrders(List<dynamic> jsons) {
  if (jsons == null) {
    return new List<Order>();
  }

  return jsons.map((value) => parseOrder(value)).toList();
}