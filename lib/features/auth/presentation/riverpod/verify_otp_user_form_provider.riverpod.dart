import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifier/verify_otp_notifier.dart';
import 'providers.dart';
import 'state/verify_otp_state.dart';

final otpUserFormProvider =
    StateNotifierProvider<VerifyOtpNotifier, VerifyOtpState>((ref) {
  final otpUserCallback = ref.watch(authProvider.notifier).otpUser;
  return VerifyOtpNotifier(
    otpCallback: otpUserCallback,
  );
});
