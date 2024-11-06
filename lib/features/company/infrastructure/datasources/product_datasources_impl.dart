import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/shared/infrastructure/service/cloudinary_init.service.riverpod.dart';
import '../../../../core/shared/shared.dart';
import '../../domain/datasources/product_datasource.dart';
import '../../domain/entities/product.dart';
import '../mapper/product_mapper.dart';
import '../models/product.module.dart';

class ProductDatasourceImpl implements ProductDatasource {
  final SupabaseClient supabase;
  static String table = 'product';
  final keyValueStorage = KeyValueStorageImpl();
  ProductDatasourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabase = supabaseClientDatasource ?? Supabase.instance.client;

  @override
  Future<Product> createProduct({
    String nameProduct = '',
    String brand = '',
    String description = '',
    bool status = false,
    String img = '',
    double price = 0.0,
    int amount = 0,
    DateTime? expireProduct,
    int idCategory = 0,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final response = await supabase.from(table).insert([
        {
          'nameproduct': nameProduct,
          'brand': brand,
          'description': description,
          'statusproduct': status,
          'imgproduct': img,
          'price': price,
          'amount': amount,
          'expire_product': expireProduct!.toIso8601String(),
          'idcategory': idCategory,
        }
      ]).select();
      final idCompany = await keyValueStorage.getValue<String>('id');
      final product = _responseProduct(response);
      await supabase.from('products_company').insert([
        {
          'id_ext': product.first.id,
          'id_company': idCompany,
        }
      ]);
      return product.first;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    throw UnimplementedError();
  }

  @override
  Stream<List<Product>> getProductsStream() async* {
    try {
      final response =
          supabase.from('inventory_company').stream(primaryKey: ['id']);

      final streamProducts = response
        ..map(
          (event) => event.map(
            (e) {
              final res = supabase
                  .from(table)
                  .stream(primaryKey: ['id_ext']).eq('id_ext', e['id_ext']);
              return res;
            },
          ),
        );
      final products = streamProducts.map((e) => _responseProduct(e));
      yield* products;
    } catch (e) {
      throw Exception('ERROR: $e');
    }
  }

  @override
  Future<Product> updateProduct({
    int idProduct = 0,
    String nameProduct = '',
    String brand = '',
    String description = '',
    bool status = false,
    String img = '',
    double price = 0.0,
    int amount = 0,
    DateTime? updateAt,
    DateTime? expireProduct,
    int idCategory = 0,
  }) async {
    try {
      final response = await supabase
          .from(table)
          .update({
            'nameproduct': nameProduct,
            'brand': brand,
            'description': description,
            'statusproduct': status,
            'imgproduct': img,
            'price': price,
            'amount': amount,
            'update_at': updateAt!.toIso8601String(),
            'expire_product': expireProduct!.toIso8601String(),
            'idcategory': idCategory,
          })
          .eq('id_ext', idProduct)
          .select();
      final product = _responseProduct(response).first;
      return product;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Product> updateProductCheck({
    required int idProduct,
    required String nameProduct,
    required String brand,
    required String description,
    required bool status,
    required String img,
    required double price,
    required int amount,
    required DateTime? updateAt,
    required DateTime? expireProduct,
    required int idCategory,
    required bool changedImage,
  }) async {
    String imgPath = '';
    if (changedImage) {
      imgPath = await CloudinaryInit.uploadImage(
        imgPath,
        UploadPreset.product,
      );
    } else {
      imgPath = img;
    }
    await Future.delayed(const Duration(milliseconds: 500));
    final product = await updateProduct(
      idProduct: idProduct,
      nameProduct: nameProduct,
      brand: brand,
      description: description,
      status: status,
      img: img,
      price: price,
      amount: amount,
      updateAt: updateAt,
      expireProduct: expireProduct,
      idCategory: idCategory,
    );
    return product;
  }

  @override
  Future<Product> getProductById({int idProduct = 0}) async {
    try {
      final response =
          await supabase.from(table).select().eq('id_ext', idProduct);
      final product = _responseProduct(response).first;
      return product;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('Product Not Found');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception('Error loading product, product: $e');
    }
  }

  @override
  Future<int> getAmountProducts() async {
    try {
      final response =
          await supabase.from(table).select().count(CountOption.exact);
      return response.count;
    } catch (e) {
      throw Exception('Error loading products $e');
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      // final inventoryIds
      final response = await supabase.from(table).select();
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }

  @override
  Future<List<Product>> getProductsOutstanding() async {
    try {
      final response = await supabase
          .from(table)
          .select()
          .order('create_at', ascending: false);
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }

  @override
  Future<Product?> getProductWithDiscountById({int idproduct = 0}) async {
    try {
      final response = await supabase
          .from('productdiscount')
          .select()
          .eq('id_ext', idproduct);
      if (response.isEmpty) {
        return null;
      }
      final product = _responseProduct(response).first;
      return product;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Product>> searchProducts(String textSearch) async {
    if (textSearch.isEmpty) return [];
    try {
      final response = await supabase
          .from(table)
          .select()
          .ilike('nameproduct', '%$textSearch%');
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<Product>> searchProductsStrean(String textSearch) {
    // TODO: implement searchProductsStrean
    throw UnimplementedError();
  }

  List<Product> _responseProduct(List<Map<String, dynamic>> response) {
    final products = response
        .map(
          (product) => ProductMapper.toProductEntity(
            ProductModel.fromJson(product),
          ),
        )
        .toList();

    return products;
  }

  @override
  Future<List<Product>> getProductsByInventory(int idInventory) async {
    try {
      final responseInventoryProduct = await supabase
          .from('inventory_product')
          .select('id_ext')
          .eq('id_inventory', idInventory);
      final listIdsProduct =
          responseInventoryProduct.map((e) => e['id_ext']).toList();

      final response = await supabase
          .from(table)
          .select()
          .inFilter('id_ext', listIdsProduct)
          .order('create_at', ascending: false);
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }

  @override
  Future<List<Product>> getProductsByCompany(String idCompany) async {
    try {
      final response = await supabase
          .from('products_company')
          .select('id_ext')
          .eq('id_company', idCompany)
        ..map((e) => e['id_ext']).toList();
      final responseProduct = await supabase
          .from(table)
          .select()
          .inFilter('id_ext', response)
          .order('create_at', ascending: false);
      final products = _responseProduct(responseProduct);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }
}
