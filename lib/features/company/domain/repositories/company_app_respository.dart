import '../../../auth/domain/domain.dart';

abstract class CompanyAppRespository {
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
  );

  Future<CompanyApp> getDataCompanyByEmail(String email);
  Future<CompanyApp> getDataCompanyById(String id);

  Future<List<CompanyApp>> getCompanies();
}
