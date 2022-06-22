import 'dart:developer';
import 'dart:io';

import 'package:calcular_preco_venda/objects/Product.dart';
import 'package:calcular_preco_venda/services/DB/ProductDAO.dart';
import 'package:path_provider/path_provider.dart';

class BasicProductDAO {
  Future<List<Product>> getAll() async {
    return await ProductDAO().getAllProduct();
  }

  Future<int> insert(Product product) async {
    print("insertBasicProduct");
    return await ProductDAO().newProduct(product);
  }

  Future<int> update(Product product) async {
    return await ProductDAO().updateProduct(product);
  }

  Future<int> delete(int productID) async {
    return await ProductDAO().deleteProduct(productID);
  }

  Future<String> getProductsFromOlderVersion() async {
    List<String> products;

    try {
      var directory = await getDownloadsDirectory();
      log("$directory");
      final File file = File('$directory/backup_markup/produtos.tr');

      if (file.existsSync()) {
        products = await file.readAsLines();

        products.forEach((product) {
          if (product.isNotEmpty) {
            List<String> prod = product.split(";");

            insert(new Product(
                id: 0,
                nome: prod[1],
                custo: double.parse(prod[2]),
                encargo: double.parse(prod[3]),
                comissao: double.parse(prod[4]),
                lucro: double.parse(prod[5]),
                outros: double.parse(prod[6]),
                imp1: double.parse(prod[7]),
                imp2: double.parse(prod[8]),
                custoIndireto: double.parse(prod[9]),
                precoFora: double.parse(prod[10]),
                precoDentro: double.parse(prod[11]),
                uriImg: prod[12].compareTo("null") == 0 ? null : prod[12]));
          }
        });

        file.deleteSync();
        log("$products");
      } else {
        log("Arquivo de backup não existe");
      }
    } catch (e) {
      log("Couldn't read file: $e");
    }
    return "text";
  }
}
