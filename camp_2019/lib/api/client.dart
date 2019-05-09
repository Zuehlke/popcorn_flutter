import 'dart:async';
import 'dart:convert';

import 'package:PopcornMaker/models/flavour.dart';
import 'package:PopcornMaker/models/machine.dart';
import 'package:PopcornMaker/models/order.dart';
import 'package:PopcornMaker/models/order_request.dart';
import 'package:http/http.dart' as http;

class Client {
  final _baseUrl =
      'https://popcornmakerbackend20190507022416.azurewebsites.net/api';
  final _headers = {'Content-Type': 'application/json'};

  Future<List<Machine>> getAllMachines() async {

    var response = await _get("$_baseUrl/machines");

    List<dynamic> getAllResponse = json.decode(response.body);

    List<Machine> result = new List<Machine>();
    for (String machineId in getAllResponse) {
      var machine = await getMachine(machineId);
      result.add(machine);
    }

    return result;
  }

  Future<Machine> getMachine(String machineId) async {
    var response = await _get("$_baseUrl/machines/$machineId");
    return parseMachine(json.decode(response.body));
  }

  Future<List<Order>> getOrders(String machineId) async {
    var response = await _get("$_baseUrl/machines/$machineId/orders");
    return parseOrders(json.decode(response.body));
  }

  Future<String> createOrder(OrderRequest orderRequest) async {
    var request = {
      "userName": orderRequest.userName,
      "amount": orderRequest.amount,
      "flavour": fromFlavour(orderRequest.flavour),
    };

    var body = json.encode(request);
    var response = await _post("$_baseUrl/machines/${orderRequest.machineId}/orders/", body);
    var responseJson = json.decode(response.body);
    return responseJson['id'];
  }

  Future<http.Response> _get(String url) => http.get(url, headers: _headers);

  Future<http.Response> _post(String url, dynamic body) => http.post(url, body: body, headers: _headers);
}
