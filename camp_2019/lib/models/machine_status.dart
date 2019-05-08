enum MachineStatus { Idle, Busy, Error }

MachineStatus parseMachineStatus(String status) {
  switch (status) {
    case 'IDLE':
      return MachineStatus.Idle;
    case 'BUSY':
      return MachineStatus.Busy;
    case 'ERROR':
      return MachineStatus.Error;
  }

  throw status;
}
