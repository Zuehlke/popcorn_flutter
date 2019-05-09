import 'dart:async';
import 'dart:convert';

import 'package:camp_2019/models/flavour.dart';
import 'package:camp_2019/models/machine.dart';
import 'package:camp_2019/models/order.dart';
import 'package:camp_2019/models/order_request.dart';
import 'package:http/http.dart' as http;

class Client {

  static final Client _instance = Client._internal();

  factory Client(){
    return _instance;
  }

  Client._internal();

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

  Future<void> createOrder(OrderRequest orderRequest) async {
    var request = {
      "userName": orderRequest.userName,
      "amount": orderRequest.amount,
      "flavour": fromFlavour(orderRequest.flavour),
    };

    var body = json.encode(request);
    var response = await _post(
        "$_baseUrl/machines/${orderRequest.machineId}/orders/", body);
    var responseJson = json.decode(response.body);
    var orderId = responseJson['id'];

    return authorizePurchase(orderRequest.machineId, orderId);
  }

  Future<void> authorizePurchase(String machineId, String orderId) async {
    var requestJson = {
      "status": "IN_QUEUE",
    };
    var url = "$_baseUrl/machines/${machineId}/orders/${orderId}";
    var body = json.encode(requestJson);
    var response = await _put(url, body);
    if (response.statusCode != 200) {
      throw response.reasonPhrase;
    }
  }

  Future<http.Response> _get(String url) => http.get(url, headers: _headers);

  Future<http.Response> _post(String url, dynamic body) =>
      http.post(url, body: body, headers: _headers);

  Future<http.Response> _put(String url, dynamic body) =>
      http.put(url, body: body, headers: _headers);
}
