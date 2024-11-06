class CompanyModel {
  final String idCompany;
  final String? imgPresentation;
  final String? bannerCompany;
  final String? accountCreated;
  final String nameCompany;
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

  CompanyModel({
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
  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        idCompany: json['id'] ?? '',
        imgPresentation: json['img_presentation'] ?? '',
        bannerCompany: json['banner_company'] ?? '',
        nameCompany: json['name_company'] ?? '',
        description: json['description_company'] ?? '',
        accountCreated: json['created_at'] ?? '',
        location: json['location'] ?? '',
        ruc: json['ruc'] ?? '',
        address: json['address'] ?? '',
        phone: json['phone'] ?? '',
        email: json['email'] ?? '',
        idDistrict: json['id_district'] ?? '',
        password: json['password'] ?? '',
        urlWeb: json['url_web'] ?? '',
        urlFacebook: json['url_facebook'] ?? '',
        urlInstagram: json['url_instragram'] ?? '',
        accountStatus: json['state_account'] ?? false,
        idTypeUser: json['id_type_user'] ?? 3,
        tokenAuth: json['token_auth'] ?? '',
        tokenStateAccount: json['token_state_account'] ?? '',
      );
}
