import 'package:ecofriendly_flutter_app/features/cart/domain/entities/cart_items.dart';
import 'package:ecofriendly_flutter_app/features/cart/infrastructure/models/cart_items.module.dart';

class CartItemsMapper {
  static CartItems toCartItemsEntity(CartItemsModel cart) => CartItems(
        id: cart.id,
        userId: cart.userId,
        productId: cart.productId,
        price: cart.price,
        quantity: cart.quantity,
      );
}
