import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/utils/functions/show_snackbar.dart';
import '../riverpod/providers.dart';

class RegisterCompanyScreen extends StatelessWidget {
  static const String name = 'register_company_screen';
  const RegisterCompanyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crea una cuenta'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height - 100,
                  child: const CompanyForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompanyForm extends ConsumerWidget {
  const CompanyForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerCompanyForm = ref.watch(registerFormCompanyProvider);

    ref.listen(
      authProvider,
      (previous, next) {
        if (next.errorMessage.isNotEmpty) {
          showSnackbar(context, next.errorMessage);
        }
        if (next.messageRegister.isNotEmpty) {
          context.go('/verify_otp_company/${registerCompanyForm.email.value}');
          showSnackbar(context, next.messageRegister);
        }
      },
    );

    final titleForm = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.grey[600],
        );
    final textChangedPassword =
        Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: MyColors.password,
            );
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 18.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Icon(
              Icons.business_sharp,
              size: 60,
              color: colors.primary,
            ),
          ),
          Text(
            'Complete los campos necesarios',
            style: titleForm,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Nombre de la empresa',
            keyboardType: TextInputType.name,
            onChanged:
                ref.read(registerFormCompanyProvider.notifier).onNameChange,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'número de contacto',
            keyboardType: TextInputType.phone,
            onChanged:
                ref.read(registerFormCompanyProvider.notifier).onPhoneChange,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged:
                ref.read(registerFormCompanyProvider.notifier).onEmailChange,
            errorMessage: registerCompanyForm.isFormPosted
                ? registerCompanyForm.email.errorMessage
                : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Contraseña',
            obscureText: registerCompanyForm.obscureTextPassword,
            onPressed:
                ref.read(registerFormCompanyProvider.notifier).onViewPassword,
            onChanged:
                ref.read(registerFormCompanyProvider.notifier).onPasswordChange,
            errorMessage: registerCompanyForm.isFormPosted
                ? registerCompanyForm.password.errorMessage
                : registerCompanyForm.statePassword == StatePassword.neutral
                    ? null
                    : registerCompanyForm.statePassword ==
                            StatePassword.notVerify
                        ? 'Las contraseñas no coinciden'
                        : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Repita la contraseña',
            obscureText: registerCompanyForm.obscureTextRepeatPassword,
            onPressed: ref
                .read(registerFormCompanyProvider.notifier)
                .onViewRepeatPassword,
            onChanged: ref
                .read(registerFormCompanyProvider.notifier)
                .onPasswordRepeatChange,
            errorMessage: registerCompanyForm.isFormPosted
                ? registerCompanyForm.repeatPassword.errorMessage
                : registerCompanyForm.statePassword == StatePassword.neutral
                    ? null
                    : registerCompanyForm.statePassword ==
                            StatePassword.notVerify
                        ? 'Las contraseñas no coinciden'
                        : null,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'REGISTRARSE',
              onPressed:
                  ref.read(registerFormCompanyProvider.notifier).onFormSubmit,
            ),
          ),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¿Ya tienes una cuenta?',
                style: textChangedPassword.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'Acceder',
                  style: textChangedPassword.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
