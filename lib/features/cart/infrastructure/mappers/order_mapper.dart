import '../../domain/entities/order.dart';
import '../models/order.module.dart';

class OrderMapper {
  static Order toOrderEntity(OrderModel order) => Order(
        id: order.id,
        userId: order.userId,
        totalPrice: order.totalPrice,
        status: order.status,
        createAt: order.createAt,
      );
}
