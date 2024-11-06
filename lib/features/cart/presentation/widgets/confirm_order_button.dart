import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/functions/show_snackbar.dart';
import '../riverpod/providers.dart';

class ConfirmOrderButton extends ConsumerWidget {
  const ConfirmOrderButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa el estado de orderConfirmProvider
    final orderConfirmState = ref.watch(orderConfirmProvider);
// Muestra mensajes de acuerdo al estado actual
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOrderStatusMessage(context, orderConfirmState);
    });
    // Retorna el botón que cambia su estado según el estado de orderConfirmProvider
    return FilledButton(
      onPressed: () async {
        // Solo permite confirmar si el estado no está en carga o ya ha sido confirmado
        if (orderConfirmState is! AsyncLoading) {
          ref.invalidate(
              orderConfirmProvider); // Reinicia el proceso de confirmación
        }
      },
      child: orderConfirmState.when(
        data: (data) => const Text('Orden Confirmada'),
        loading: () => const Text('Procesando...'),
        error: (error, stackTrace) => const Text('Error en la Orden'),
      ),
    );
  }
}

// Muestra los mensajes con SnackBar según el estado de la orden
void showOrderStatusMessage(BuildContext context, AsyncValue<bool> state) {
  state.when(
    data: (data) {
      showSnackbar(context, 'Orden Confirmada');
    },
    loading: () {
      showSnackbar(context, 'Procesando...');
    },
    error: (error, stackTrace) {
      showSnackbar(context, 'Error de Orden: $error');
    },
  );
}
