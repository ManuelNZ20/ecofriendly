class UserLoginModel {
  final String id;
  final String email;
  final String password;
  final String tokenAuth;
  final int idTypeUser;

  UserLoginModel({
    required this.id,
    required this.email,
    required this.password,
    required this.tokenAuth,
    required this.idTypeUser,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        id: json['id'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        tokenAuth: json['token_auth'] ?? '',
        idTypeUser: json['id_type_user'] ?? 0,
      );
}
