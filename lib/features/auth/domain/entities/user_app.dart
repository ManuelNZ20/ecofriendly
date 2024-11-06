class UserApp {
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

  UserApp({
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
    this.idTypeUser = 2,
    required this.tokenAuth,
    required this.tokenStateAccount,
  });

  bool get isAdmin {
    return idTypeUser == 2;
  }
}
