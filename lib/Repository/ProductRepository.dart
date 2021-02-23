  
import 'package:calcular_preco_venda/objects/ProductCom.dart';

abstract class ProductRepository {

  Future<int> insertProduct(ProductCom product);

  Future updateProduct(ProductCom product);

  Future deleteProduct(int productId);

  Future<List<ProductCom>> getAllProducts();
}