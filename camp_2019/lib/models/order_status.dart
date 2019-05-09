enum OrderStatus { Undefined, InQueue, InProgress, Complete, AwaitingPayment }

OrderStatus parseOrderStatus(String status) {
  switch (status) {
    case 'IN_QUEUE':
      return OrderStatus.InQueue;
    case 'IN_PROGRESS':
      return OrderStatus.InProgress;
    case "COMPLETE":
      return OrderStatus.Complete;
    case 'AWAITING_PAYMENT':
      return OrderStatus.AwaitingPayment;
  }

  return OrderStatus.Undefined;
}
