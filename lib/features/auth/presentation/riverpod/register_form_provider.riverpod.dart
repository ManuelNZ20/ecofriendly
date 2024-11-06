import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../../core/shared/infrastructure/inputs/inputs.dart';
import '../../../../core/constants/constants.dart';
import 'providers.dart';

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).register;
  return RegisterFormNotifier(
    registerUserCallback: registerUserCallback,
  );
});

// 2 - Como implementar el notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String, String) registerUserCallback;
  RegisterFormNotifier({required this.registerUserCallback})
      : super(RegisterFormState());

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
      name: value,
      isValid: true,
    );
  }

  onLastNameChange(String value) {
    state = state.copyWith(
      lastName: value,
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
    await registerUserCallback(
      state.email.value,
      state.password.value,
      state.name,
      state.lastName,
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
class RegisterFormState {
  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.name = '',
    this.lastName = '',
    this.repeatPassword = const Password.pure(),
    this.isCheckAccount = false,
    this.statePassword = StatePassword.neutral,
    this.obscureTextPassword = true,
    this.obscureTextRepeatPassword = true,
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    String? name,
    String? lastName,
    Password? repeatPassword,
    bool? isCheckAccount,
    StatePassword? statePassword,
    bool? obscureTextPassword,
    bool? obscureTextRepeatPassword,
  }) =>
      RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
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
  final String name;
  final String lastName;
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
    name: $name
    last_name: $lastName
    password: $password
    ''';
  }
}
