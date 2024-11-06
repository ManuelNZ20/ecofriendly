import 'package:ecofriendly_flutter_app/features/cart/domain/entities/cart_items.dart';

abstract class CartItemsDatasource {
  Future<List<CartItems>> addProductToCart(
    int productId,
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
}
