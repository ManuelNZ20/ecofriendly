import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/shared/infrastructure/service/supabase_cliente_provider.riverpod.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

final productDiscountRepositoryProvider =
    Provider<ProductDiscountRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  final productDiscountRepository = ProductDiscountRepositoryImpl(
    supabaseClient: supabaseClient,
    productDiscountDatasource: ProductDiscountDataSourceImpl(),
  );

  return productDiscountRepository;
});
