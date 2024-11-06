import '../../domain/entities/order_item.dart';
import '../models/order_item.module.dart';

class OrderItemMapper {
  static OrderItem toOrderItemEntity(OrderItemModel order) => OrderItem(
        id: order.id,
        orderId: order.orderId,
        productId: order.productId,
        quantity: order.quantity,
        price: order.price,
      );
}
