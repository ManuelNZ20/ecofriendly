import '../../../auth/domain/domain.dart';
import '../../domain/domain.dart';

class CompanyAppRepositoryImpl implements CompanyAppRespository {
  final CompanyAppDatasource companyAppDatasource;
  CompanyAppRepositoryImpl({
    required this.companyAppDatasource,
  });

  @override
  Future<List<CompanyApp>> getCompanies() async {
    return await companyAppDatasource.getCompanies();
  }

  @override
  Future<CompanyApp> getDataCompanyByEmail(String email) async {
    return await companyAppDatasource.getDataCompanyByEmail(email);
  }

  @override
  Future<CompanyApp> getDataCompanyById(String id) async {
    return await companyAppDatasource.getDataCompanyById(id);
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
    return await companyAppDatasource.updateDataCompany(
      id,
      imgPresentation,
      bannerCompany,
      nameCompany,
      descriptionCompany,
      location,
      ruc,
      address,
      phone,
      email,
      urlWeb,
      urlFacebook,
      urlInstagram,
    );
  }
}
