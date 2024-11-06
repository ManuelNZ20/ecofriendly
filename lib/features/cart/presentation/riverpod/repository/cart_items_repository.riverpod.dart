import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

final cartItemsRepositoryProvider = Provider<CartItemsRepository>((ref) {
  return CartItemsRepositoryImpl(CartItemsDatasourceImpl());
});
