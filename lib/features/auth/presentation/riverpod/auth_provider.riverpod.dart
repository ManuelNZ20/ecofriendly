import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/shared/infrastructure/infrastructure.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageImpl();
  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;
  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final userLogin = await authRepository.login(email, password);
      // print(userLogin.idTypeUser);
      if (userLogin.idTypeUser == 1) {
        // print(userLogin.idTypeUser);
        final user = await authRepository.getDataUser(userLogin.id);
        _setLoggedUser(user);
        return;
      }
      if (userLogin.idTypeUser == 3) {
        // print(userLogin.idTypeUser);
        final company = await authRepository.getDataCompany(userLogin.id);
        _setLoggedCompany(company);
        return;
      }
      // state = state.copyWith(messageRegister: 'Usuario registrado exitosamente'); Inicia sesion
    } on WrongCredentials {
      logout(errorMessage: 'Credenciales no son correctas');
    } on ConnectionTimeout {
      logout(errorMessage: 'No cuenta con conexión a internet');
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } on Exception catch (e) {
      logout(errorMessage: 'Error no controlado, $e');
    }
  }

  Future<void> register(
    String email,
    String password,
    String name,
    String lastName,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.signUp(
        email,
        password,
        name,
        lastName,
      );
      _setLoggedUser(user);
      state = state.copyWith(messageRegister: 'Datos Confirmados');
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } on Exception catch (e) {
      logout(errorMessage: e.toString());
    }
  }

  Future<void> registerCompany(
      String email, String password, String nameCompany, String phone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final company = await authRepository.signUpCompany(
        email,
        password,
        nameCompany,
        phone,
      );
      _setLoggedCompany(company);
      state = state.copyWith(messageRegister: 'Datos Comfirmados');
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } on Exception catch (e) {
      logout(errorMessage: e.toString());
    }
  }

  Future<void> otpUser(String otp1, String otp2, String otp3, String otp4,
      String otp5, String otp6, String email) async {
    try {
      final user = await authRepository.checkUserOtp(
          otp1, otp2, otp3, otp4, otp5, otp6, email);
      _setLoggedUser(user);
      state = state.copyWith(messageRegister: 'Registro Exitoso');
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } on Exception catch (e) {
      logout(errorMessage: e.toString());
    }
  }

  Future<void> otpCompany(String otp1, String otp2, String otp3, String otp4,
      String otp5, String otp6, String email) async {
    try {
      final company = await authRepository.checkCompanyOtp(
          otp1, otp2, otp3, otp4, otp5, otp6, email);
      _setLoggedCompany(company);
      state = state.copyWith(messageRegister: 'Registro Exitoso');
    } on CustomError catch (e) {
      logout(errorMessage: e.message);
    } on Exception catch (e) {
      logout(errorMessage: e.toString());
    }
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');
    final typeUser = await keyValueStorageService.getValue<int>('type_user');
    if (token == null || typeUser == null) return logout();
    try {
      switch (typeUser) {
        case 1:
          final user = await authRepository.checkAuthStatusUser(token);
          _setLoggedUser(user);
          break;
        case 2:
          break; // si implementar
        case 3:
          final company = await authRepository.checkAuthStatusCompany(token);
          _setLoggedCompany(company);
          break;
      }
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(UserApp user) async {
    await keyValueStorageService.setKeyValue<String>('token', user.tokenAuth!);
    await keyValueStorageService.setKeyValue<int>(
        'type_user', user.idTypeUser!);
    await keyValueStorageService.setKeyValue<String>('id', user.id);
    state = state.copyWith(
      user: user,
      company: null,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
      messageRegister: '',
    );
  }

  void _setLoggedCompany(CompanyApp company) async {
    await keyValueStorageService.setKeyValue<String>(
        'token', company.tokenAuth!);
    await keyValueStorageService.setKeyValue<int>(
        'type_user', company.idTypeUser!);
    await keyValueStorageService.setKeyValue<String>('id', company.idCompany);
    state = state.copyWith(
      company: company,
      user: null,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
      messageRegister: '',
    );
  }

  Future<void> logout({String? errorMessage}) async {
    await keyValueStorageService.removeKey('token');
    await keyValueStorageService.removeKey('type_user');
    await keyValueStorageService.removeKey('id');
    // Verificar si los valores se eliminaron correctamente
    final token = await keyValueStorageService.getValue<String>('token');
    final typeUser = await keyValueStorageService.getValue<int>('type_user');
    final id = await keyValueStorageService.getValue<String>('id');
    if (token != null || typeUser != null || id != null) {
      // print(
      //     'Error: el token o el tipo de usuario aún persisten después de logout');
    }
    state = state.copyWith(
      authStatus: AuthStatus.noAuthenticated,
      user: null,
      company: null,
      errorMessage: errorMessage ?? '',
      messageRegister: '',
    );
  }
}

enum AuthStatus {
  checking,
  authenticated,
  noAuthenticated,
  verifyRegister,
}

class AuthState {
  final AuthStatus authStatus;
  final UserApp? user;
  final CompanyApp? company;
  final String errorMessage;
  final String messageRegister;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.company,
    this.errorMessage = '',
    this.messageRegister = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    UserApp? user,
    CompanyApp? company,
    String? errorMessage,
    String? messageRegister,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        company: company ?? this.company,
        errorMessage: errorMessage ?? this.errorMessage,
        messageRegister: messageRegister ?? this.messageRegister,
      );
}
