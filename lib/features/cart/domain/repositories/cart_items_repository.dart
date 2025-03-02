import 'package:ecofriendly_flutter_app/features/cart/domain/entities/cart_items.dart';

abstract class CartItemsRepository {
  Future<List<CartItems>> addProductToCart(
    int productId,
    String nameProduct,
    String userId,
    int quantity,
    double price,
  );
  Future<bool> updateQuantityProductToCart(
    int quantity,
    int productId,
    String userId,
  );

  Future<List<CartItems>> getProductToCart(
    int productId,
    String userId,
  );
  Future<List<CartItems>> getProductsToCart(
    String userId,
  );

  Future<bool> removeProduct(int productId, String userId);

  Future<bool> clearCart(String userId);

  Future<void> createdOrderFormCart(String userId);
}
