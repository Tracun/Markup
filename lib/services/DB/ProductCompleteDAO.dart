import 'dart:developer';

import 'package:calcular_preco_venda/Repository/ProductRepository.dart';
import 'package:calcular_preco_venda/services/DB/GenericModel.dart';
import 'package:calcular_preco_venda/objects/ProductCom.dart';

class ProductCompleteDAO implements ProductRepository {
  final GenericModel _genericModel = GenericModel("product");

  @override
  Future<int> insertProduct(ProductCom product) async {
    log("INSERINDO NO GENERIC");
    var key = await _genericModel.insert(product.toMap());
    // Insere o id do produto criado e atualiza
    product.id = key;
    updateProduct(product);
    return key;
  }

  @override
  Future updateProduct(ProductCom product) async {
    log("ATUALIZANDO NO GENERIC");
    await _genericModel.update(product.toMap());
  }

  @override
  Future deleteProduct(int productId) async {
    var ret = await _genericModel.delete(productId);
    log('RETORNO DELETE GENERIC: $ret');
  }

  @override
  Future<List<ProductCom>> getAllProducts() async {
    final snapshots = await _genericModel.getAllProducts();
    log("GENERIC - LENGHT: ${snapshots.length}");
    return snapshots;
  }

  Future<ProductCom> getById(productId) async {
    return await _genericModel.getProductById(productId);
  }
}
