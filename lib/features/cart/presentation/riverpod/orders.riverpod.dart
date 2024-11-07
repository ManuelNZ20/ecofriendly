import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared/infrastructure/infrastructure.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final ordersNotifierProvider =
    StateNotifierProvider<OrdersNotifier, List<Order>>((ref) {
  final orderRepository = ref.watch(orderRepositoryProvider);
  final keyValueStorageService = KeyValueStorageImpl();
  return OrdersNotifier(
    orderRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

// Definición de `orderConfirmProvider`
final orderConfirmProvider = FutureProvider.autoDispose<bool>((ref) async {
  final cartsItems = ref.read(cartNotifierProvider);
  if (cartsItems.isNotEmpty) {
    final totalPrice = cartsItems.fold<double>(
      0.0,
      (sum, element) => sum + element.price * element.quantity,
    );

    final ordersItems = cartsItems
        .map(
          (e) => OrderItem(
            id: 0,
            orderId: 0,
            productId: e.productId,
            quantity: e.quantity,
            price: e.price,
            createAt: '',
          ),
        )
        .toList();

    await ref.read(ordersNotifierProvider.notifier).createOrder(
          ordersItems,
          totalPrice,
        );

    ref.read(cartNotifierProvider.notifier).clearCart();
    return true;
  }
  return false;
});

class OrdersNotifier extends StateNotifier<List<Order>> {
  OrdersNotifier(
    this._orderRepository, {
    required this.keyValueStorageService,
  }) : super([]) {
    loadFetchOrders();
  }
  final KeyValueStorageService keyValueStorageService;
  final OrderRepository _orderRepository;
  Future<void> loadFetchOrders() async {
    final userId = await keyValueStorageService.getValue<String>('id');
    final orders = await _orderRepository.getOrdersByUser(userId!);
    state = [
      ...state,
      ...orders,
    ];
  }

  Future<void> updateOrderStatus(int orderId, String status) async {
    await _orderRepository.updateOrderStatus(
      orderId,
      status,
    );
    state = state.map((e) {
      if (e.id == orderId) {
        return e.copyWith(
          status: status,
        );
      }
      return e;
    }).toList();
  }

  Future<void> createOrder(List<OrderItem> items, double totalPrice) async {
    final userId = await keyValueStorageService.getValue<String>('id');
    final newOrder = await _orderRepository.createOrder(
      items,
      userId!,
      totalPrice,
    );
    state = [
      ...state,
      newOrder,
    ];
  }
}
