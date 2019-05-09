
import 'package:PopcornMaker/models/flavour.dart';
import 'package:PopcornMaker/models/order_status.dart';
import 'package:PopcornMaker/models/serving_size.dart';
import 'package:PopcornMaker/utils/utils.dart';

class Order {
  Order(this.id, this.machineId, this.userName, this.size, this.flavour, this.status, this.pickupTime);

  String id;
  String machineId;
  String userName;
  ServingSize size;
  Flavour flavour;
  OrderStatus status;
  DateTime pickupTime;
}


Order parseOrder(dynamic json) {
  var id = json['id'];
  var machineId = json['machineId'];
  var userName = json['userName'];
  var size = parseServingSize(json['amount']);
  var flavour = parseFlavour(json['flavour']);
  var pickupTime = Utils.parseDateTime(json['pickupTime']);
  var status = parseOrderStatus(json['status']);

  return Order(id, machineId, userName, size, flavour, status, pickupTime);
}

List<Order> parseOrders(List<dynamic> jsons) {
  if (jsons == null) {
    return new List<Order>();
  }

  return jsons.map((value) => parseOrder(value)).toList();
}