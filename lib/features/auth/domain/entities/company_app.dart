class CompanyApp {
  final String idCompany;
  final String? imgPresentation;
  final String? bannerCompany;
  final String nameCompany;
  final String? accountCreated;
  final String? description;
  final String? location;
  final String? ruc;
  final String? address;
  final String phone;
  final String email;
  final String? idDistrict;
  final String password;
  final String? urlWeb;
  final String? urlFacebook;
  final String? urlInstagram;
  final int? idTypeUser;
  final bool? accountStatus;
  final String? tokenAuth;
  final String? tokenStateAccount;

  CompanyApp({
    required this.idCompany,
    required this.imgPresentation,
    required this.bannerCompany,
    required this.nameCompany,
    required this.accountCreated,
    required this.description,
    required this.location,
    required this.ruc,
    required this.address,
    required this.phone,
    required this.email,
    required this.idDistrict,
    required this.password,
    required this.urlWeb,
    required this.urlFacebook,
    required this.urlInstagram,
    this.idTypeUser = 3,
    required this.accountStatus,
    required this.tokenAuth,
    required this.tokenStateAccount,
  });
}
