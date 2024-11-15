import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final ordersItemsByCompanyProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final supabase = Supabase.instance.client;
  final response = await supabase.from('products_company').select();
  final responseOrderByCompany =
      await supabase.from('orders_items').select().inFilter(
            'product_id',
            response.map((e) => e['id_ext']).toList(),
          );

  return responseOrderByCompany;
});

final ordersByCompanyProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final supabase = Supabase.instance.client;
  final response = await supabase.from('products_company').select();
  final responseOrderByCompany =
      await supabase.from('orders_items').select().inFilter(
            'product_id',
            response.map((e) => e['id_ext']).toList(),
          );
  final responseOrdersByCompany =
      await supabase.from('orders').select().inFilter(
            'id_orders',
            responseOrderByCompany.map((e) => e['order_id']).toList(),
          );
  return responseOrdersByCompany;
});

final ordersByCompanyFromUsersProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final supabase = Supabase.instance.client;
  final response = await supabase.from('products_company').select();
  final responseOrderByCompany =
      await supabase.from('orders_items').select().inFilter(
            'product_id',
            response.map((e) => e['id_ext']).toList(),
          );
  final responseOrdersByCompany =
      await supabase.from('orders').select().inFilter(
            'id_orders',
            responseOrderByCompany.map((e) => e['order_id']).toList(),
          );
  final responseData = await supabase.from('orders').select(
    '''
    user_app(email),
    orders_items(price,quantity),
    total_price,
    status
    ''',
  ).inFilter(
    'id_orders',
    responseOrderByCompany.map((e) => e['order_id']).toList(),
  );
  return responseData;
});
