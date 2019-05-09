import 'package:camp_2019/models/flavour.dart';

class OrderRequest{
  String machineId;
  String userName;
  int amount;
  Flavour flavour;

  OrderRequest(this.machineId, this.userName, this.amount, this.flavour);
}