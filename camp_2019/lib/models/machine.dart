import 'package:PopcornMaker/models/flavour.dart';
import 'package:PopcornMaker/models/level.dart';
import 'package:PopcornMaker/models/machine_status.dart';

class Machine {
  String id;
  MachineStatus status;
  Level level;
  List<Flavour> flavours;

  Machine(this.id, this.status, this.level, this.flavours);
}

Machine parseMachine(dynamic json) {
  var id = json['id'];
  var status = parseMachineStatus(json['status']);
  var level = Level(json['cornLevel']);
  var flavours = parseFlavours(json['flavours']);

  return Machine(id, status, level, flavours);
}
