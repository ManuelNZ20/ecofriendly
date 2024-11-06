import '../../domain/domain.dart';
import '../models/company_app.module.dart';

class CompanyAppMapper {
  static CompanyApp companyJsonToEntity(CompanyModel company) => CompanyApp(
        idCompany: company.idCompany,
        imgPresentation: company.imgPresentation,
        bannerCompany: company.bannerCompany,
        nameCompany: company.nameCompany,
        accountCreated: company.accountCreated,
        description: company.description,
        location: company.location,
        ruc: company.ruc,
        address: company.address,
        phone: company.phone,
        email: company.email,
        idDistrict: company.idDistrict,
        password: company.password,
        urlWeb: company.urlWeb,
        urlFacebook: company.urlFacebook,
        urlInstagram: company.urlInstagram,
        accountStatus: company.accountStatus,
        tokenAuth: company.tokenAuth,
        tokenStateAccount: company.tokenStateAccount,
      );
}
