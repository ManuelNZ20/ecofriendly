import '../../../../../core/constants/constants.dart';

class VerifyOtpState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String number1;
  final String number2;
  final String number3;
  final String number4;
  final String number5;
  final String number6;
  final StateAccount stateAccount;
  final String email;

  VerifyOtpState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.number1 = '',
    this.number2 = '',
    this.number3 = '',
    this.number4 = '',
    this.number5 = '',
    this.number6 = '',
    this.stateAccount = StateAccount.notVerify,
    this.email = '',
  });

  VerifyOtpState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    String? number1,
    String? number2,
    String? number3,
    String? number4,
    String? number5,
    String? number6,
    StateAccount? stateAccount,
    String? email,
  }) =>
      VerifyOtpState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        number1: number1 ?? this.number1,
        number2: number2 ?? this.number2,
        number3: number3 ?? this.number3,
        number4: number4 ?? this.number4,
        number5: number5 ?? this.number5,
        number6: number6 ?? this.number6,
        stateAccount: stateAccount ?? this.stateAccount,
        email: email ?? this.email,
      );

  @override
  String toString() {
    return '''
    VerifyOtp
    isPosting: $isPosting
    isFormPosting: $isFormPosted
    isValid: $isValid
    number: $number1,$number2,$number3,$number4,$number5,$number6
    ''';
  }
}
