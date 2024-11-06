import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../../core/constants/constants.dart';
import 'auth_provider.riverpod.dart';
import '../../../../core/shared/infrastructure/inputs/inputs.dart';

final registerFormCompanyProvider = StateNotifierProvider<
    RegisterFormCompanyNotifier, RegisterFormCompanyState>((ref) {
  final registerCompanyCallback =
      ref.watch(authProvider.notifier).registerCompany;
  return RegisterFormCompanyNotifier(
    registerCompanyCallback: registerCompanyCallback,
  );
});

// 2 - Como implementar el notifier
class RegisterFormCompanyNotifier
    extends StateNotifier<RegisterFormCompanyState> {
  final Function(String, String, String, String) registerCompanyCallback;
  RegisterFormCompanyNotifier({required this.registerCompanyCallback})
      : super(RegisterFormCompanyState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email]),
    );
  }

  onNameChange(String value) {
    state = state.copyWith(
      nameCompany: value,
      isValid: true,
    );
  }

  onPhoneChange(String value) {
    state = state.copyWith(
      phone: value,
      isValid: true,
    );
  }

  onPasswordRepeatChange(String value) {
    final repeatPassword = Password.dirty(value);
    state = state.copyWith(
      repeatPassword: repeatPassword,
      isValid: Formz.validate([state.password, state.email, repeatPassword]),
    );
  }

  onViewPassword() {
    state = state.copyWith(obscureTextPassword: !state.obscureTextPassword);
  }

  onViewRepeatPassword() {
    state = state.copyWith(
        obscureTextRepeatPassword: !state.obscureTextRepeatPassword);
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    await registerCompanyCallback(
      state.email.value,
      state.password.value,
      state.nameCompany,
      state.phone,
    );
    state = state.copyWith(
      isCheckAccount: true,
      statePassword: StatePassword.verify,
    );
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final repeatPassword = Password.dirty(state.repeatPassword.value);
    if (state.password.value != state.repeatPassword.value) {
      state = state.copyWith(
        statePassword: StatePassword.notVerify,
        isValid: false,
      );
      return;
    }
    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        repeatPassword: repeatPassword,
        isValid: Formz.validate([email, password, repeatPassword]));
  }
}

// 1 - Crear el estado de este provider - State provider
class RegisterFormCompanyState {
  RegisterFormCompanyState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.nameCompany = '',
    this.phone = '',
    this.repeatPassword = const Password.pure(),
    this.isCheckAccount = false,
    this.statePassword = StatePassword.neutral,
    this.obscureTextPassword = true,
    this.obscureTextRepeatPassword = true,
  });

  RegisterFormCompanyState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    String? nameCompany,
    String? phone,
    Password? repeatPassword,
    bool? isCheckAccount,
    StatePassword? statePassword,
    bool? obscureTextPassword,
    bool? obscureTextRepeatPassword,
  }) =>
      RegisterFormCompanyState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        nameCompany: nameCompany ?? this.nameCompany,
        phone: phone ?? this.phone,
        repeatPassword: repeatPassword ?? this.repeatPassword,
        isCheckAccount: isCheckAccount ?? this.isCheckAccount,
        statePassword: statePassword ?? this.statePassword,
        obscureTextPassword: obscureTextPassword ?? this.obscureTextPassword,
        obscureTextRepeatPassword:
            obscureTextRepeatPassword ?? this.obscureTextRepeatPassword,
      );

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final String nameCompany;
  final String phone;
  final Password repeatPassword;
  final bool isCheckAccount;
  final StatePassword statePassword;
  final bool obscureTextPassword;
  final bool obscureTextRepeatPassword;

  @override
  String toString() {
    return '''
    LoginFormState
    isPosting: $isPosting
    isFormPosting: $isFormPosted
    isValid: $isValid
    email: $email
    name: $nameCompany
    last_name: $phone
    password: $password
    ''';
  }
}
