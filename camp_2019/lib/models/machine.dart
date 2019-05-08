import 'package:camp_2019/models/level.dart';
import 'package:camp_2019/models/machine_status.dart';

class Machine {
  String id;
  MachineStatus status;
  Level level;

  Machine(this.id, this.status, this.level);
}

Machine parseMachine(dynamic json) {
  return Machine(json['id'],
      parseMachineStatus(json['status']), Level(json['cornLevel']));
}
