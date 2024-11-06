import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../infrastructure/datasources/inventory_datasources_impl.dart';
import '../../../infrastructure/infrastructure.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return InventoryRepositoryImpl(
    inventoryDatasource: InventoryDatasourcesImpl(),
  );
});
