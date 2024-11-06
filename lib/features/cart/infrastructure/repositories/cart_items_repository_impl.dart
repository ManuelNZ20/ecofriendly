import 'package:ecofriendly_flutter_app/features/cart/domain/datasouces/cart_items_datasources.dart';
import 'package:ecofriendly_flutter_app/features/cart/domain/entities/cart_items.dart';
import '../../domain/repositories/cart_items_repository.dart';

class CartItemsRepositoryImpl extends CartItemsRepository {
  final CartItemsDatasource datasource;

  CartItemsRepositoryImpl(this.datasource);
  @override
  Future<List<CartItems>> addProductToCart(
    int productId,
    String userId,
    int quantity,
    double price,
  ) async {
    return await datasource.addProductToCart(
      productId,
      userId,
      quantity,
      price,
    );
  }

  @override
  Future<List<CartItems>> getProductToCart(int productId, String userId) async {
    return await datasource.getProductToCart(
      productId,
      userId,
    );
  }

  @override
  Future<List<CartItems>> getProductsToCart(String userId) async {
    return await datasource.getProductsToCart(
      userId,
    );
  }

  @override
  Future<bool> updateQuantityProductToCart(
      int quantity, int productId, String userId) async {
    return await datasource.updateQuantityProductToCart(
      quantity,
      productId,
      userId,
    );
  }
}
