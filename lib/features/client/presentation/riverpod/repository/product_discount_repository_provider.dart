import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/shared/infrastructure/service/supabase_cliente_provider.riverpod.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../infrastructure/infrastructure.dart';

final productDiscountRepositoryProvider =
    Provider<ProductDiscountClientRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  final productDiscountRepository = ProductDiscountClientRepositoryImpl(
    supabaseClient: supabaseClient,
    productDiscountDatasource: ProductDiscountClientDataSourceImpl(),
  );

  return productDiscountRepository;
});
