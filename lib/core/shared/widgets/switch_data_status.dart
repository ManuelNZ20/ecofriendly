import 'package:flutter/material.dart';

class SwitchDataStatus extends StatelessWidget {
  const SwitchDataStatus({
    super.key,
    required this.isActive,
    required this.onChanged,
  });
  final bool isActive;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SwitchListTile(
        value: isActive,
        onChanged: onChanged,
        title: Text(
          isActive ? 'Activo' : 'Inactivo',
        ),
      ),
    );
  }
}
