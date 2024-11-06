import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carro de Compras'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 40,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Index $index'),
                subtitle: Text('Index $index'),
                leading: const Icon(Icons.online_prediction_rounded),
                onTap: () {},
                trailing: const Icon(Icons.subdirectory_arrow_left),
              );
            },
          ),
          Positioned(
            bottom: 10,
            child: SizedBox(
              width: size.width,
              height: 80,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                width: size.width * .8,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          )
          // const _MessageEmptyContent(),
        ],
      ),
    );
  }
}

class _MessageEmptyContent extends StatelessWidget {
  const _MessageEmptyContent();

  @override
  Widget build(BuildContext context) {
    final titleMessage = Theme.of(context).textTheme.titleMedium;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.remove_shopping_cart_outlined,
            size: 100,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: Text(
              '¡Ups! Parece que tu carrito está vacío. ¿Porque no agregar algo que te guste?',
              style: titleMessage,
            ),
          )
        ],
      ),
    );
  }
}
