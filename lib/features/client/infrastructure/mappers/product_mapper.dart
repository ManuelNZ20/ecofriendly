import '../../domain/entities/product_client.dart';
import '../model/product_client_model.dart';

class ProductClientMapper {
  static ProductClient toProductEntity(ProductClientModel product) =>
      ProductClient(
        id: product.id,
        idProduct: product.idproduct,
        nameProduct: product.nameproduct,
        brand: product.brand,
        description: product.description,
        status: product.status,
        img: product.imgproduct,
        price: product.price,
        amount: product.amount,
        idCategory: product.idcategory,
        createAt: product.createAt,
        expireProduct: product.expireProduct,
        updateAt: product.updateAt,
        idproductdiscount: product.idproductdiscount,
        discountpercentage: product.discountpercentage,
      );
}
