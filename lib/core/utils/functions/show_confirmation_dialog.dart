import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/cart/presentation/riverpod/providers.dart';

void showConfirmationDialog(BuildContext context, WidgetRef ref, int orderId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmación de pago'),
        content: const Text(
            '¿Estás seguro de que deseas realizar el pago y cambiar el estado de la orden?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo sin hacer nada
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Actualizar el estado de la orden
              ref
                  .read(ordersNotifierProvider.notifier)
                  .updateOrderStatus(orderId, 'CONFIRMAR');
              Navigator.of(context).pop(); // Cierra el diálogo
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Estado de la orden actualizado a pagado')),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      );
    },
  );
}
