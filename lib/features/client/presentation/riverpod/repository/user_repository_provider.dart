import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/infrastructure/service/supabase_cliente_provider.riverpod.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../infrastructure/datasources/datasources.dart';
import '../../../infrastructure/repositories/repositories.dart';

final userAppRepositoryProvider = Provider<UserClientRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  final userRepository = UserClientRepositoryImpl(
    supabaseClient: supabaseClient,
    userDatasource: UserDatasourceImpl(),
  );
  return userRepository;
});
