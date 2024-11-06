import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/router/app_router_notifier.dart';
import '../../../../config/theme/theme.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/utils/functions/show_snackbar.dart';
import '../../../client/presentation/riverpod/connectivity_app.riverpod.dart';
import '../riverpod/providers.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'login_screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height - 100,
                  child: const LoginForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends ConsumerWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final loginForm = ref.watch(loginFormProvider);
    final titleLogin = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: colors.primary,
        );
    final textChangedPassword =
        Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: MyColors.password,
            );
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      }
      if (next.messageRegister.isNotEmpty) {
        showSnackbar(context, next.messageRegister);
      }
    });

    final connectionStatus = ref.watch(connectionStatusProvider);
    return connectionStatus.when(
      data: (status) {
        if (status == ConnectionStatus.connected) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.eco_outlined,
                  color: colors.primary,
                  size: 150,
                  weight: .3,
                  shadows: listShadowCard,
                ),
                Text(
                  '¡Bienvenido a Ecofriendly!',
                  style: titleLogin,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Correo',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
                  errorMessage: loginForm.isFormPosted
                      ? loginForm.email.errorMessage
                      : null,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Contraseña',
                  obscureText: loginForm.obscureText,
                  onPressed:
                      ref.read(loginFormProvider.notifier).onViewPassword,
                  onChanged:
                      ref.read(loginFormProvider.notifier).onPasswordChange,
                  errorMessage: loginForm.isFormPosted
                      ? loginForm.password.errorMessage
                      : null,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '¿Olvidate tu contraseña?',
                        style: textChangedPassword,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: CustomFilledButton(
                    text: 'INICIAR SESIÓN',
                    onPressed: !loginForm.isPosting
                        ? ref.read(loginFormProvider.notifier).onFormSubmit
                        : null,
                  ),
                ),
                // const SizedBox(height: 20),
                const Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿No tienes cuenta?',
                      style: textChangedPassword.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.push('/business_option'),
                      child: Text(
                        'Registrate',
                        style: textChangedPassword.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
                // const Spacer(flex: 1),
              ],
            ),
          );
        }
        return const _ReloadConnectivity();
      },
      error: (error, stackTrace) {
        return const _ReloadConnectivity();
      },
      loading: () {
        return const Center(
          child: _ReloadConnectivity(),
        );
      },
    );
  }
}

class _ReloadConnectivity extends ConsumerWidget {
  const _ReloadConnectivity();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Su conexión a fallado'),
        TextButton.icon(
          onPressed: () async {
            ref.invalidate(goRouterNotifierProvider);
            ref.invalidate(authProvider);
            // ref.invalidate(authProvider);
            print('ninsaf');
          },
          icon: const Icon(Icons.replay_outlined),
          label: const Text('Intentar otra vez'),
        ),
      ],
    );
  }
}
