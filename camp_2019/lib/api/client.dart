import 'dart:async';
import 'dart:convert';

import 'package:PopcornMaker/models/flavour.dart';
import 'package:PopcornMaker/models/machine.dart';
import 'package:PopcornMaker/models/order.dart';
import 'package:PopcornMaker/models/order_request.dart';
import 'package:PopcornMaker/models/serving_size.dart';
import 'package:http/http.dart' as http;

class Client {
  static final Client _instance = Client._internal();

  factory Client() {
    return _instance;
  }

  Client._internal();

  final _baseUrl =
      'https://popcornmakerbackend20190507022416.azurewebsites.net/api';
  final _headers = {'Content-Type': 'application/json'};

  Future<List<Machine>> getAllMachines() async {
    var response = await _get("$_baseUrl/machines");

    List<dynamic> getAllResponse = [];
    if (response.statusCode == 200) {
      getAllResponse = json.decode(response.body);
    }

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
    List<Order> orders = parseOrders(json.decode(response.body));
    orders.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    return orders;
  }

  Future<void> createOrder(OrderRequest orderRequest) async {
    var request = {
      "userName": orderRequest.userName,
      "amount": fromServingSize(orderRequest.size),
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
    var url = "$_baseUrl/machines/$machineId/orders/$orderId";
    var body = json.encode(requestJson);
    var response = await _put(url, body);
    throwOnError(response);
  }

  Future<http.Response> _get(String url) async {
    var response = await http.get(url, headers: _headers);
    throwOnError(response);
    return response;
  }

  Future<http.Response> _post(String url, dynamic body) async{
    var response = await http.post(url, body: body, headers: _headers);
    throwOnError(response);
    return response;
  }

  Future<http.Response> _put(String url, dynamic body) async {
    var response = await http.put(url, body: body, headers: _headers);
    throwOnError(response);
    return response;
  }

  void throwOnError(http.Response response) {
    if (response.statusCode != 200) {
      throw response.reasonPhrase;
    }
  }

  Future<String> getPayLink(Order order) async {
    var url = "http://159.69.212.159:3000/invoice";
    var body = {'orderId': order.id,'machineId': order.machineId};
    var response = await _post(url, json.encode(body));
    var responseJson = json.decode(response.body);
    return responseJson['payment_request'];
  }
}
