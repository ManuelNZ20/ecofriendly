import 'package:flutter/material.dart';

class MessageEmptyContent extends StatelessWidget {
  const MessageEmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    final titleMessage = Theme.of(context).textTheme.titleMedium;

    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.remove_shopping_cart_outlined,
            size: 70,
            color: colors.primary,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            child: Text(
              '¡Ups! Parece que tu carrito está vacío. ¿Porque no agregas algo que te guste?',
              style: titleMessage,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
