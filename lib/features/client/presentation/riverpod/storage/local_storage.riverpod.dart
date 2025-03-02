import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/infrastructure.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(
    IsarDatasource(),
  );
});
