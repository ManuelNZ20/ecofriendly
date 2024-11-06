import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared/infrastructure/infrastructure.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final inventoryFormProvider = StateNotifierProvider.family<
    InventoryFormNotifier, InventoryFormState, Inventory>((ref, inventory) {
  final createdOrUpdateInventory =
      ref.watch(inventoriesProvider.notifier).createdOrUpdateInventory;
  return InventoryFormNotifier(
    inventory: inventory,
    onSubmit: createdOrUpdateInventory,
  );
});

class InventoryFormNotifier extends StateNotifier<InventoryFormState> {
  final Future<bool> Function(int id, String name, String description,
      String idCompany, String createAt)? onSubmit;

  final keyValueStorageService = KeyValueStorageImpl();
  InventoryFormNotifier({
    this.onSubmit,
    required Inventory inventory,
  }) : super(
          InventoryFormState(
            isFormValid: true,
            id: inventory.id,
            name: inventory.name,
            description: inventory.description,
            idCompany: inventory.idCompany,
            createAt: inventory.dateRegister,
          ),
        );
  void onNameChange(String value) {
    state = state.copyWith(
      name: value,
      isFormValid: true,
    );
  }

  void onDescriptionChange(String value) {
    state = state.copyWith(
      description: value,
      isFormValid: true,
    );
  }

  Future<bool> onFormSubmit() async {
    if (!state.isFormValid) return false;
    if (onSubmit == null) return false;
    try {
      final id = await keyValueStorageService.getValue<String>('id');
      state = state.copyWith(
        idCompany: id,
        isFormValid: true,
      );
      print(id);
      return await onSubmit!(
        state.id,
        state.name,
        state.description,
        state.idCompany,
        state.createAt,
      );
    } catch (e) {
      return false;
    }
  }
}

class InventoryFormState {
  final bool isFormValid;
  final int id;
  final String name;
  final String description;
  final String idCompany;
  final String createAt;

  InventoryFormState({
    this.isFormValid = false,
    this.id = 0,
    this.name = '',
    this.description = '',
    this.idCompany = '',
    this.createAt = '',
  });

  InventoryFormState copyWith({
    bool? isFormValid,
    int? id,
    String? name,
    String? description,
    String? idCompany,
    String? createAt,
  }) =>
      InventoryFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        idCompany: idCompany ?? this.idCompany,
        createAt: createAt ?? this.createAt,
      );
}
