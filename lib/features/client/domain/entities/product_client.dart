import 'package:isar/isar.dart';
part 'product_client.g.dart';

@collection
class ProductClient {
  Id? isarId;
  final int id;
  final String idProduct;
  final String nameProduct;
  final String brand;
  final String description;
  final bool status;
  final String img;
  final double price;
  final int amount; //unit
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime expireProduct;
  final int idCategory;
  // final ProductClientDiscount? productDiscount;
  final String idproductdiscount;
  final double discountpercentage; //discount_percentage
  final bool? isFavorite;

  ProductClient({
    required this.id,
    required this.idProduct,
    required this.nameProduct,
    required this.brand,
    required this.description,
    required this.status,
    required this.img,
    required this.price,
    required this.amount,
    required this.createAt,
    required this.updateAt,
    required this.expireProduct,
    required this.idCategory,
    required this.idproductdiscount,
    required this.discountpercentage,
    // required this.productDiscount,
    this.isFavorite = false,
  });

  ProductClient copyWith({
    int? id,
    String? idProduct,
    String? nameProduct,
    String? brand,
    String? description,
    bool? status,
    String? img,
    double? price,
    int? amount, //uni,
    DateTime? createAt,
    DateTime? updateAt,
    DateTime? expireProduct,
    int? idCategory,
    String? idproductdiscount,
    double? discountpercentage,
    bool? isFavorite,
  }) =>
      ProductClient(
        id: id ?? this.id,
        idProduct: idProduct ?? this.idProduct,
        nameProduct: nameProduct ?? this.nameProduct,
        brand: brand ?? this.brand,
        description: description ?? this.description,
        status: status ?? this.status,
        img: img ?? this.img,
        price: price ?? this.price,
        amount: amount ?? this.amount,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
        expireProduct: expireProduct ?? this.expireProduct,
        idCategory: idCategory ?? this.idCategory,
        idproductdiscount: idproductdiscount ?? this.idproductdiscount,
        discountpercentage: discountpercentage ?? this.discountpercentage,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
