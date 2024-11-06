import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/company/presentation/providers/categories_provider.dart';

class DropdownCategories extends ConsumerWidget {
  const DropdownCategories({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    const borderRadius = BorderRadius.all(
      Radius.circular(10),
    );
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        strokeAlign: 4.0,
      ),
      borderRadius: borderRadius,
    );
    final List<DropdownMenuItem<String>> items = categories.isLoading
        ? [
            const DropdownMenuItem(
              value: 'Cargando...',
              child: Text('Cargando...'),
            ),
          ]
        : categories.categories
            .where(
              (element) => element.status,
            )
            .map(
              (e) => DropdownMenuItem(
                value: e.idCategory,
                child: Text(e.name),
              ),
            )
            .toList();
    if (items.isNotEmpty && !items.any((element) => element.value == value)) {
      items.insert(
        0,
        DropdownMenuItem<String>(
          value: value,
          child: const Text('Seleccione una categoría'),
        ),
      );
    }
    return DropdownButtonFormField<String>(
      value: value,
      borderRadius: borderRadius,
      decoration: const InputDecoration(
        label: Text('Categorías'),
        enabledBorder: outlineInputBorder,
        border: outlineInputBorder,
      ),
      items: items,
      onChanged: onChanged,
      isExpanded: true,
    );
  }
}
