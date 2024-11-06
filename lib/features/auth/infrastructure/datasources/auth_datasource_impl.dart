import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../emails/domain/domain.dart';
import '../../../emails/infrastructure/infrastructure.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';
import '../mappers/user_login_mapper.dart';
import '../models/user_login.module.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final supabase = Supabase.instance.client;
  @override
  Future<UserApp> checkAuthStateAccount(String? otp) {
    throw UnimplementedError();
  }

  @override
  Future<UserApp> checkAuthStatusUser(String? token) async {
    try {
      final user =
          await supabase.from('user_app').select().eq('token_auth', token!);
      final userModel = UserModel.fromJson(user.first);
      final userApp = UserAppMapper.userJsonToEntity(userModel);
      return userApp;
    } on AuthException catch (e) {
      if (e.statusCode == '400') {
        throw CustomError(e.message, e.code!);
      }
      if (e.statusCode == '401') {
        throw CustomError('Token Incorrecto', e.code!);
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<CompanyApp> checkAuthStatusCompany(String? token) async {
    try {
      final company =
          await supabase.from('company_app').select().eq('token_auth', token!);
      final companyModel = CompanyModel.fromJson(company.first);
      final companyApp = CompanyAppMapper.companyJsonToEntity(companyModel);
      return companyApp;
    } on AuthException catch (e) {
      if (e.statusCode == '400') {
        throw CustomError(e.message, e.code!);
      }
      if (e.statusCode == '401') {
        throw CustomError('Token Incorrecto', e.code!);
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Session?> getSessionSupabase() {
    throw UnimplementedError();
  }

  @override
  bool isLoggedIn() {
    throw UnimplementedError();
  }

  @override
  StreamSubscription<AuthState> listenToAuthStatus() {
    throw UnimplementedError();
  }

  @override
  Future<UserLogin> login(String email, String password) async {
    try {
      final resUser = await _userLogin(email, password, 'user_app');
      if (resUser != null) {
        final userLoginModel = UserLoginModel.fromJson(resUser);
        final userLoginApp =
            UserLoginMapper.fromEntityUserLogin(userLoginModel);
        return userLoginApp;
      }
      final resCompany = await _userLogin(email, password, 'company_app');
      if (resCompany != null) {
        final userLoginModel = UserLoginModel.fromJson(resCompany);
        final userLoginApp =
            UserLoginMapper.fromEntityUserLogin(userLoginModel);
        return userLoginApp;
      }
      throw CustomError('Esta cuenta no existe', '500');
    } on AuthException catch (e) {
      if (e.statusCode == '400') {
        throw CustomError(e.message, e.code!);
      }
      if (e.statusCode == '401') {
        throw CustomError('Credenciales Incorrectas A', e.code!);
      }
      throw CustomError('Something wrong happend', e.code ?? '');
    } on Exception catch (e) {
      throw CustomError('Credenciales Incorrectas $e', '500');
    }
  }

  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  @override
  Future<UserApp> signUp(
      String email, String password, String name, String lastName) async {
    try {
      final response = await _signUpUser(
        email: email,
        password: password,
        name: name,
        lastName: lastName,
      );
      final data = response;
      if (data.isEmpty) {
        throw CustomError('No se puede registrar al usuario', '500');
      }
      final userModel = UserModel.fromJson(data);
      final userApp = UserAppMapper.userJsonToEntity(userModel);
      return userApp;
    } on CustomError catch (e) {
      throw CustomError('No se puede registrar, ${e.message}', '500');
    } on Exception catch (e) {
      throw Exception('Error al registrarse usuario $e');
    }
  }

  @override
  Future<CompanyApp> signUpCompany(
      String email, String password, String nameCompany, String phone) async {
    try {
      final response = await _signUpCompany(
        email: email,
        password: password,
        name: nameCompany,
        phone: phone,
      );
      final data = response;
      if (data.isEmpty) {
        throw CustomError('No se puede registrar esta cuenta', '500');
      }
      final companyModel = CompanyModel.fromJson(data);
      final companyApp = CompanyAppMapper.companyJsonToEntity(companyModel);
      return companyApp;
    } on CustomError catch (e) {
      throw CustomError('No se puede registrar, ${e.message}', '500');
    } on Exception catch (e) {
      throw Exception('Error al registrarse usuario $e');
    }
  }

  @override
  Future<UserApp> checkUserOtp(String otp1, String otp2, String otp3,
      String otp4, String otp5, String otp6, String email) async {
    try {
      final token = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
      final res = await _validToken(email, token, 'user_app');
      if (res.isEmpty) {
        throw CustomError('El token es invalido', '500');
      }
      await supabase.from('user_app').update({
        'state_account': true,
      }).eq('email', email);
      final userModel = UserModel.fromJson(res.first);
      final userApp = UserAppMapper.userJsonToEntity(userModel);
      return userApp;
    } on CustomError catch (e) {
      throw CustomError('No se puede registrar, ${e.message}', '500');
    } on Exception catch (e) {
      throw Exception('Error al registrarse $e');
    }
  }

  @override
  Future<CompanyApp> checkCompanyOtp(String otp1, String otp2, String otp3,
      String otp4, String otp5, String otp6, String email) async {
    try {
      final token = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
      final res = await _validToken(email, token, 'company_app');
      if (res.isEmpty) {
        throw CustomError('El token es invalido', '500');
      }
      await supabase.from('company_app').update({
        'state_account': true,
      }).eq('email', email);
      final companyModel = CompanyModel.fromJson(res.first);
      final companyApp = CompanyAppMapper.companyJsonToEntity(companyModel);
      return companyApp;
    } on CustomError catch (e) {
      throw CustomError('No se puede registrar, ${e.message}', '500');
    } on Exception catch (e) {
      throw Exception('Error al registrarse $e');
    }
  }

  Future<Map<String, dynamic>> _signUpUser({
    String email = '',
    String password = '',
    String name = '',
    String lastName = '',
  }) async {
    try {
      final detectedEmailCompany =
          await _detectedEmail(email, true, 'company_app');
      final detectedEmailUser = await _detectedEmail(email, true, 'user_app');
      if (detectedEmailCompany || detectedEmailUser) {
        throw CustomError('Este correo electronico ya existe', '500');
      }
      final token = const Uuid().v4().substring(0, 6);
      final EmailRepositories sendEmail =
          EmailRepositoryImpl(emailDatasources: EmailDatasourceImpl());
      sendEmail.sendEmailToken(
        email: email,
        token: token,
      );
      // final hashPassword = BCrypt.hashpw(password, BCrypt.gensalt());

      final resp = await supabase.from('user_app').insert({
        'email': email,
        'password': password,
        'name': name,
        'last_name': lastName,
        'token_state_account': token,
        'id_type_user': 1,
      }).select();
      return resp.first;
    } on CustomError catch (e) {
      throw CustomError(e.message, '500');
    } on Exception catch (e) {
      throw Exception(
          'Error durante la solicitud de registro: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> _signUpCompany({
    String email = '',
    String password = '',
    String name = '',
    String phone = '',
  }) async {
    try {
      final detectedEmailCompany =
          await _detectedEmail(email, true, 'company_app');
      final detectedEmailUser = await _detectedEmail(email, true, 'user_app');
      if (detectedEmailCompany || detectedEmailUser) {
        throw CustomError('Este correo electronico ya existe', '500');
      }
      final token = const Uuid().v4().substring(0, 6);
      final EmailRepositories sendEmail =
          EmailRepositoryImpl(emailDatasources: EmailDatasourceImpl());
      sendEmail.sendEmailToken(
        email: email,
        token: token,
      );
      // final hashPassword = BCrypt.hashpw(password, BCrypt.gensalt());
      final resp = await supabase.from('company_app').insert({
        'email': email,
        'password': password,
        'name_company': name,
        'phone': phone,
        'token_state_account': token,
        'id_type_user': 3,
      }).select();
      return resp.first;
    } on CustomError catch (e) {
      throw CustomError(e.message, '500');
    } on Exception catch (e) {
      throw Exception(
          'Error durante la solicitud de registro: ${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> _validToken(
      String email, String token, String table) async {
    final res = await supabase
        .from(table)
        .select()
        .eq('email', email)
        .eq('token_state_account', token);
    return res;
  }

  Future<bool> _detectedEmail(
      String email, bool stateAccount, String table) async {
    final detectedEmail = await supabase
        .from(table)
        .select()
        .eq('email', email)
        .eq('state_account', stateAccount);
    return detectedEmail.isNotEmpty;
  }

  Future<Map<String, dynamic>?> _userLogin(
      String email, String password, String table) async {
    try {
      final response = await supabase.from(table).select('''
                id,
                email,
                password,
                token_auth,
                id_type_user
          ''').eq('email', email).eq('password', password);
      if (response.isEmpty) {
        throw CustomError('No se encontró ninguna cuenta en $table', '404');
      }

      return response.first;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserApp> getDataUser(String id) async {
    try {
      final data = await supabase.from('user_app').select().eq('id', id);
      final userModel = UserModel.fromJson(data.first);
      final userApp = UserAppMapper.userJsonToEntity(userModel);
      return userApp;
    } on TimeoutException {
      throw CustomError('Solicitud de datos timeout', '500');
    }
  }

  @override
  Future<CompanyApp> getDataCompany(String id) async {
    try {
      final data = await supabase.from('company_app').select().eq('id', id);
      final companyModel = CompanyModel.fromJson(data.first);
      final companyApp = CompanyAppMapper.companyJsonToEntity(companyModel);
      return companyApp;
    } on TimeoutException {
      throw CustomError('Solicitud de datos timeout', '500');
    }
  }
}
