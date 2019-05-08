import 'dart:convert';

import 'package:camp_2019/models/machine.dart';
import 'package:http/http.dart' as http;

class Client {
  final String _baseUrl =  'https://popcornmakerbackend20190507022416.azurewebsites.net/api';

  Future<List<Machine>> getAllMachines() async {

    var url = "${_baseUrl}/machines";
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    List<dynamic> getAllResponse = json.decode(response.body);

    List<Machine> result = new List<Machine>();
    for (String machineId in getAllResponse) {
      var machine = await getMachine(machineId);
      result.add(machine);
    }

    return result;
  }

  Future<Machine> getMachine(String machineId) async {

    var url = "$_baseUrl/machines/$machineId";
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);
    dynamic machineDto = json.decode(response.body);

    return new Machine(machineDto['id'], machineDto['id']);
  }
}
