import 'package:flutter/material.dart';

class ChipStateCard extends StatelessWidget {
  const ChipStateCard({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: isActive ? Colors.green[300] : Colors.red[300],
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(isActive ? 'Activo' : 'Inactivo'),
        ],
      ),
      padding: EdgeInsets.zero,
    );
  }
}
