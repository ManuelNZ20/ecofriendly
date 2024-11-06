import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../infrastructure/datasources/company_app_datasources_impl.dart';
import '../../../infrastructure/repositories/company_app_repository_impl.dart';

final companyAppRepositoryProvider = Provider<CompanyAppRespository>((ref) {
  final companyRepository = CompanyAppRepositoryImpl(
    companyAppDatasource: CompanyAppDatasourcesImpl(),
  );
  return companyRepository;
});
