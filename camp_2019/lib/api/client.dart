import 'dart:convert';

import 'package:camp_2019/models/machine.dart';
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
    dynamic machineDto = json.decode(response.body);

    // TODO extend Machine
    return new Machine(machineDto['id'], machineDto['id']);
  }

  Future<http.Response> _get(String url) async => await http.get(url, headers: _headers);

}
