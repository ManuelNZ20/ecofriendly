import '../../domain/domain.dart';
import '../infrastructure.dart';

class CartItemsMapper {
  static CartItems toCartItemsEntity(CartItemsModel cart) => CartItems(
        id: cart.id,
        userId: cart.userId,
        productId: cart.productId,
        price: cart.price,
        quantity: cart.quantity,
        nameProduct: cart.nameProduct,
      );
}
