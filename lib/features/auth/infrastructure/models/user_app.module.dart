class UserModel {
  final String id;
  final String email;
  final String password;
  final String? accountCreated;
  final String? name;
  final String? lastName;
  final int? age;
  final String? phone;
  final String? idDisctrict;
  final String? gender;
  final String? address;
  final String? referenceAddress;
  final bool? accountStatus;
  final int? idTypeUser;
  final String? tokenAuth;
  final String? tokenStateAccount;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.accountCreated,
    required this.name,
    required this.lastName,
    required this.age,
    required this.phone,
    required this.idDisctrict,
    required this.gender,
    required this.address,
    required this.referenceAddress,
    required this.accountStatus,
    this.idTypeUser = 1,
    required this.tokenAuth,
    required this.tokenStateAccount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        accountCreated: json['created_at'] ?? '',
        name: json['name'] ?? '',
        lastName: json['last_name'] ?? '',
        age: json['age'] ?? 0,
        phone: json['phone'] ?? '',
        idDisctrict: json['id_disctricts'] ?? '',
        gender: json['gender'] ?? '',
        address: json['address'] ?? '',
        referenceAddress: json['reference_address'] ?? '',
        accountStatus: json['state_account'] ?? false,
        idTypeUser: json['id_type_user'] ?? 1,
        tokenAuth: json['token_auth'] ?? '',
        tokenStateAccount: json['token_state_account'] ?? '',
      );
}
