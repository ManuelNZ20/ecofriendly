import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  static const String name = 'order_detail_screen';
  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la orden #$orderId'),
      ),
      body: Container(),
    );
  }
}
