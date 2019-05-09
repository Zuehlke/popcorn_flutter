enum OrderStatus { Undefined, InQueue, InProgress, Complete }

OrderStatus parseOrderStatus(String status) {
  switch (status) {
    case 'IN_QUEUE':
      return OrderStatus.InQueue;
    case 'IN_PROGRESS':
      return OrderStatus.InProgress;
    case "COMPLETE":
      return OrderStatus.Complete;
  }

  return OrderStatus.Undefined;
}
