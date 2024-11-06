import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/shared.dart';
import '../../../../../core/utils/functions/show_snackbar.dart';
import '../../../domain/domain.dart';
import '../../providers/forms/inventory_form.riverpod.dart';
import '../../providers/inventory_provider.riverpod.dart';

class InventoryScreen extends ConsumerWidget {
  static const String name = 'inventory_screen';
  const InventoryScreen({
    super.key,
    required this.idInventory,
  });

  final int idInventory;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventory = ref.watch(inventoryProvider(idInventory));
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Editar inventario'),
      ),
      body: inventory.isLoading
          ? const FullScreenLoader()
          : _InventoryInformation(
              inventory: inventory.inventory!,
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref
              .read(inventoryFormProvider(inventory.inventory!).notifier)
              .onFormSubmit()
              .then((onValue) {
            if (!onValue) return;
            showSnackbar(context, 'Inventario actualizado');
          });
        },
        label: const Text('Guardar'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}

class _InventoryInformation extends ConsumerWidget {
  const _InventoryInformation({
    required this.inventory,
  });
  final Inventory inventory;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryForm = ref.watch(inventoryFormProvider(inventory));

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Nombre',
              initialValue: inventoryForm.name,
              onChanged: ref
                  .read(inventoryFormProvider(inventory).notifier)
                  .onNameChange,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Descripción',
              initialValue: inventoryForm.description,
              onChanged: ref
                  .read(inventoryFormProvider(inventory).notifier)
                  .onDescriptionChange,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
