import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/constants.dart';
import '../state/verify_otp_state.dart';

class VerifyOtpNotifier extends StateNotifier<VerifyOtpState> {
  final Function(String, String, String, String, String, String, String)
      otpCallback;
  VerifyOtpNotifier({
    required this.otpCallback,
  }) : super(VerifyOtpState());

  onOtp1Change(String value) {
    if (!mounted) return; // Verifica si el widget sigue montado

    state = state.copyWith(
      isValid: true,
      number1: value,
    );
  }

  onOtp2Change(String value) {
    if (!mounted) return; // Verifica si el widget sigue montado
    state = state.copyWith(
      isValid: true,
      number2: value,
    );
  }

  onOtp3Change(String value) {
    if (!mounted) return; // Verifica si el widget sigue montado
    state = state.copyWith(
      isValid: true,
      number3: value,
    );
  }

  onOtp4Change(String value) {
    if (!mounted) return; // Verifica si el widget sigue montado
    state = state.copyWith(
      isValid: true,
      number4: value,
    );
  }

  onOtp5Change(String value) {
    if (!mounted) return; // Verifica si el widget sigue montado
    state = state.copyWith(
      isValid: true,
      number5: value,
    );
  }

  onOtp6Change(String value) {
    if (!mounted) return; // Verifica si el widget sigue montado
    state = state.copyWith(
      isValid: true,
      number6: value,
    );
  }

  onEmailChange(String value) {
    if (!mounted) return; // Verifica si el widget sigue montado
    state = state.copyWith(
      email: value,
      isValid: true,
    );
  }

  onFormSubmitOtp() async {
    if (!mounted) return; // Verifica si el widget sigue montado
    await otpCallback(
      state.number1,
      state.number2,
      state.number3,
      state.number4,
      state.number5,
      state.number6,
      state.email,
    );
    if (!mounted) return; // Verifica si el widget sigue montado
    state = state.copyWith(
      stateAccount: StateAccount.verify,
    );
  }
}
