import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepositoryImpl(
    OrderDatasourceImpl(),
  );
});
