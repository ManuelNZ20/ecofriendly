import '../../domain/domain.dart';
import '../models/user_login.module.dart';

class UserLoginMapper {
  static UserLogin fromEntityUserLogin(UserLoginModel user) => UserLogin(
        id: user.id,
        email: user.email,
        password: user.password,
        tokenAuth: user.tokenAuth,
        idTypeUser: user.idTypeUser,
      );
}
