import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/utils/functions/show_snackbar.dart';
import '../riverpod/providers.dart';

class RegisterUserScreen extends StatelessWidget {
  static const String name = 'register_user_screen';
  const RegisterUserScreen({super.key});

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
                  child: const UserForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserForm extends ConsumerWidget {
  const UserForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);

    ref.listen(
      authProvider,
      (previous, next) {
        if (next.errorMessage.isNotEmpty) {
          showSnackbar(context, next.errorMessage);
        }
        if (next.messageRegister.isNotEmpty) {
          context.go('/verify_otp_user/${registerForm.email.value}');
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
              Icons.person,
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
            label: 'Nombres',
            keyboardType: TextInputType.name,
            onChanged: ref.read(registerFormProvider.notifier).onNameChange,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Apellidos',
            keyboardType: TextInputType.name,
            onChanged: ref.read(registerFormProvider.notifier).onLastNameChange,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.email.errorMessage
                : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Contraseña',
            obscureText: registerForm.obscureTextPassword,
            onPressed: ref.read(registerFormProvider.notifier).onViewPassword,
            onChanged: ref.read(registerFormProvider.notifier).onPasswordChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.password.errorMessage
                : registerForm.statePassword == StatePassword.neutral
                    ? null
                    : registerForm.statePassword == StatePassword.notVerify
                        ? 'Las contraseñas no coinciden'
                        : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Repita la contraseña',
            obscureText: registerForm.obscureTextRepeatPassword,
            onPressed:
                ref.read(registerFormProvider.notifier).onViewRepeatPassword,
            onChanged:
                ref.read(registerFormProvider.notifier).onPasswordRepeatChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.repeatPassword.errorMessage
                : registerForm.statePassword == StatePassword.neutral
                    ? null
                    : registerForm.statePassword == StatePassword.notVerify
                        ? 'Las contraseñas no coinciden'
                        : null,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'REGISTRARSE',
              onPressed: ref.read(registerFormProvider.notifier).onFormSubmit,
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
