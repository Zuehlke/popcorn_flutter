import 'package:PopcornMaker/models/flavour.dart';
import 'package:PopcornMaker/models/serving_size.dart';

class OrderRequest{
  String machineId;
  String userName;
  ServingSize size;
  Flavour flavour;

  OrderRequest(this.machineId, this.userName, this.size, this.flavour);
}