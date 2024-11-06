import '../infrastructure.dart';
import '../../domain/domain.dart';

class OrderItemMapper {
  static OrderItem toOrderItemEntity(OrderItemModel order) => OrderItem(
        id: order.id,
        orderId: order.orderId,
        productId: order.productId,
        quantity: order.quantity,
        price: order.price,
        createAt: order.createAt,
      );
}
