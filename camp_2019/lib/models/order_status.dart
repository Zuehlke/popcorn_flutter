enum OrderStatus { InQueue, InProgress }

OrderStatus parseOrderStatus(String status) {
  switch (status) {
    case 'IN_QUEUE':
      return OrderStatus.InQueue;
    case 'IN_PROGRESS':
      return OrderStatus.InProgress;
  }

  throw status;
}
