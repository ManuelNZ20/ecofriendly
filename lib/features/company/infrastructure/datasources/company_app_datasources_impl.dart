import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/infrastructure/infrastructure.dart';
import '../../domain/domain.dart';
import '../../../auth/domain/domain.dart';

class CompanyAppDatasourcesImpl implements CompanyAppDatasource {
  final String table = 'company_app';
  final supabase = Supabase.instance.client;
  @override
  Future<List<CompanyApp>> getCompanies() async {
    try {
      final response = await supabase.from(table).select();
      final listCompanies = response.map(
        (e) {
          final company = responseCompany(e);
          return company;
        },
      ).toList();
      return listCompanies;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<CompanyApp> getDataCompanyByEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Future<CompanyApp> getDataCompanyById(String id) async {
    try {
      final res =
          await supabase.from(table).select().eq('id', id).limit(1).single();
      final company = responseCompany(res);
      return company;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<CompanyApp> updateDataCompany(
    String id,
    String imgPresentation,
    String bannerCompany,
    String nameCompany,
    String descriptionCompany,
    String location,
    String ruc,
    String address,
    String phone,
    String email,
    String urlWeb,
    String urlFacebook,
    String urlInstagram,
  ) async {
    try {
      final response = await supabase
          .from(table)
          .update({
            'img_presentation': imgPresentation,
            'banner_company': bannerCompany,
            'name_company': nameCompany,
            'description_company': descriptionCompany,
            'location': location,
            'ruc': ruc,
            'address': address,
            'phone': phone,
            'email': email,
            'url_web': urlWeb,
            'url_facebook': urlFacebook,
            'url_instragram': urlInstagram,
          })
          .eq('id', id)
          .select();
      final company = responseCompany(response.first);
      return company;
    } catch (e) {
      throw Exception(e);
    }
  }

  CompanyApp responseCompany(Map<String, dynamic> json) {
    try {
      final companyModel = CompanyModel.fromJson(json);
      final company = CompanyAppMapper.companyJsonToEntity(companyModel);
      return company;
    } catch (e) {
      print('Problema en el mapeo de datos');
      throw Exception('Error: $e');
    }
  }
}
