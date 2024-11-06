import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/utils/functions/show_snackbar.dart';
import '../riverpod/providers.dart';

class VerifyCompanyOtpScreen extends StatelessWidget {
  static const String name = 'verify_otp_company_screen';
  const VerifyCompanyOtpScreen({
    super.key,
    required this.email,
  });
  final String email;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: CompanyFormOtp(
          email: email,
        ),
      ),
    );
  }
}

class CompanyFormOtp extends ConsumerWidget {
  const CompanyFormOtp({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Usa Future.delayed para retrasar la modificación del estado
    Future.microtask(() {
      ref.read(otpCompanyFormProvider.notifier).onEmailChange(email);
    });
    ref.listen(
      authProvider,
      (previous, next) {
        if (next.errorMessage.isNotEmpty) {
          showSnackbar(context, next.errorMessage);
        }
        if (next.messageRegister.isNotEmpty) {
          context.go('/login');
          showSnackbar(context, next.messageRegister);
        }
      },
    );
    final titleForm = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.grey[600],
        );
    final titleOtp = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        );
    final textChangedPassword =
        Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: MyColors.password,
            );
    // Usa ref.watch en lugar de ref.read para escuchar cambios en el estado
    final otpNotifier = ref.read(otpCompanyFormProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Verificación OTP',
            style: titleOtp,
          ),
          const SizedBox(height: 20),
          Text(
            'Se le ha enviado un código de verificación a su correo electronico',
            style: titleForm,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFieldOtp(
                onChanged: otpNotifier.onOtp1Change,
              ),
              TextFieldOtp(
                onChanged: otpNotifier.onOtp2Change,
              ),
              TextFieldOtp(
                onChanged: otpNotifier.onOtp3Change,
              ),
              TextFieldOtp(
                onChanged: otpNotifier.onOtp4Change,
              ),
              TextFieldOtp(
                onChanged: otpNotifier.onOtp5Change,
              ),
              TextFieldOtp(
                onChanged: otpNotifier.onOtp6Change,
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'VERIFICAR',
              onPressed:
                  ref.read(otpCompanyFormProvider.notifier).onFormSubmitOtp,
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => context.go('/login'),
            child: Text(
              'Cancelar',
              style: textChangedPassword.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
