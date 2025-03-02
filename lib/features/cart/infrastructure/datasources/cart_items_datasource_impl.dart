import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/datasouces/cart_items_datasources.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class CartItemsDatasourceImpl extends CartItemsDatasource {
  final supabase = Supabase.instance.client;
  @override
  Future<List<CartItems>> addProductToCart(
    int productId,
    String nameProduct,
    String userId,
    int quantity,
    double price,
  ) async {
    try {
      final response = await supabase.from('cart_items').insert([
        {
          'product_id': productId,
          'user_id': userId,
          'quantity': quantity,
          'price': price,
          'name_product': nameProduct,
        }
      ]).select();
      final listCarts = response.map((e) => _responseToEntityCart(e)).toList();
      return listCarts;
    } catch (e) {
      print(e);
      throw Exception('Error add cart $e');
    }
  }

  @override
  Future<List<CartItems>> getProductToCart(int productId, String userId) async {
    throw UnimplementedError();
    // try {
    //   final response = await supabase.from('cart_items').select();
    // } catch (e) {}
  }

  @override
  Future<List<CartItems>> getProductsToCart(String userId) async {
    try {
      final response =
          await supabase.from('cart_items').select().eq('user_id', userId);
      final cartsItems = response.map((e) => _responseToEntityCart(e)).toList();
      return cartsItems;
    } catch (e) {
      print(e);
      throw Exception('Error cart_items $e');
    }
  }

  @override
  Future<bool> updateQuantityProductToCart(
      int quantity, int productId, String userId) async {
    try {
      final response = await supabase
          .from('cart_items')
          .update({
            'quantity': quantity,
          })
          .eq('user_id', userId)
          .eq('product_id', productId)
          .select();
      return response.isNotEmpty;
    } catch (e) {
      print(e);
      throw Exception('Error update cart_items $e');
    }
  }

  CartItems _responseToEntityCart(Map<String, dynamic> response) {
    final model = CartItemsModel.fromJson(response);
    final cart = CartItemsMapper.toCartItemsEntity(model);
    return cart;
  }

  @override
  Future<bool> clearCart(String userId) async {
    try {
      final response = await supabase
          .from('cart_items')
          .delete()
          .eq('user_id', userId)
          .select();
      return response.isNotEmpty;
    } catch (e) {
      print('Error delete cart $e');
      return false;
    }
  }

  @override
  Future<void> createdOrderFormCart(String userId) async {}

  @override
  Future<bool> removeProduct(
    int productId,
    String userId,
  ) async {
    try {
      final response = await supabase
          .from('cart_items')
          .delete()
          .eq('product_id', productId)
          .eq('user_id', userId)
          .select();
      return response.isNotEmpty;
    } catch (e) {
      print('Error remove cart $e');
      return false;
    }
    // final response = await supabase
  }
}
