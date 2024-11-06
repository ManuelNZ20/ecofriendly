import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/shared/shared.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, List<CartItems>>((ref) {
  final keyValueStorageService = KeyValueStorageImpl();
  final cartRepository = ref.read(cartItemsRepositoryProvider);
  return CartNotifier(
    cartRepository,
    keyValueStorageService,
  );
});

class CartNotifier extends StateNotifier<List<CartItems>> {
  final KeyValueStorageService keyValueStorageService;
  CartNotifier(this._cartRepository, this.keyValueStorageService) : super([]) {
    loadCartItems();
  }

  final CartItemsRepository _cartRepository;

  Future<void> loadCartItems() async {
    final userId = await keyValueStorageService.getValue<String>('id');
    final product = await _cartRepository.getProductsToCart(userId!);
    state = [
      ...state,
      ...product,
    ];
  }

  Future<void> addProductToCart(
    int productId,
    String nameProduct,
    int quantity,
    double price,
  ) async {
    final userId = await keyValueStorageService.getValue<String>('id');

    // Verifica si el producto ya existe en el carrito
    final existingProductIndex =
        state.indexWhere((item) => item.productId == productId);

    if (!(existingProductIndex != -1)) {
      final product = await _cartRepository.addProductToCart(
        productId,
        nameProduct,
        userId!,
        quantity,
        price,
      );
      state = [
        ...state,
        product.first,
      ];
    }
  }

  Future<void> removeProduct(int productId, String userId) async {
    await _cartRepository.removeProduct(productId, userId);
    state = state
        .where(
          (e) => e.productId != productId,
        )
        .toList();
  }

  Future<void> clearCart() async {
    final userId = await keyValueStorageService.getValue<String>('id');
    await _cartRepository.clearCart(userId!);
    state.clear();
    state = [];
  }

  Future<void> updateProduct(int quantity, int productId) async {
    final userId = await keyValueStorageService.getValue<String>('id');

    final response = await _cartRepository.updateQuantityProductToCart(
      quantity,
      productId,
      userId!,
    );
    if (response) {
      state = state.map((e) {
        if (e.productId == productId) {
          return e.copyWith(
            quantity: quantity,
          );
        }
        return e;
      }).toList();
    }
  }

  Future<void> incrementProductQuantity(int productId) async {
    // Encuentra el producto actual en el estado
    final currentProduct = state.firstWhere((e) => e.productId == productId);

    // Incrementa la cantidad actual en 1 y actualiza el producto
    final newQuantity = currentProduct.quantity + 1;
    await updateProduct(newQuantity, productId);
  }

  Future<void> decrementProductQuantity(int productId) async {
    // Encuentra el producto actual en el estado
    final currentProduct = state.firstWhere((e) => e.productId == productId);
    if (currentProduct.quantity <= 1) return;
    // Decrementa la cantidad actual en 1 y actualiza el producto
    final newQuantity = currentProduct.quantity - 1;
    await updateProduct(newQuantity, productId);
  }

  double totalProductsCart() {
    double total = 0;
    for (final p in state) {
      total += (p.price * p.quantity);
    }
    return total;
  }
}
