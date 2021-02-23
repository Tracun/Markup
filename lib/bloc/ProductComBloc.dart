import 'dart:async';

import 'package:calcular_preco_venda/services/DB/ProductCompleteDAO.dart';
import 'package:calcular_preco_venda/objects/ProductCom.dart';

class ProductCompleteBloc {
  //Get instance of the Repository
  final _productDAO = ProductCompleteDAO();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _productController = StreamController<List<ProductCom>>.broadcast();

  get products => _productController.stream;

  ProductCompleteBloc() {
    getAll();
  }

  getAll() async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _productController.sink.add(await _productDAO.getAllProducts());
  }

  Future<int> newProduct(ProductCom product) async {
    var ret = await _productDAO.insertProduct(product);
    getAll();
    return ret;
  }

  Future<int> updateProduct(ProductCom product) async {
    var ret = await _productDAO.updateProduct(product);
    getAll();
    return ret;
  }

  Future<int> deleteById(int id) async {
    var ret = await _productDAO.deleteProduct(id);
    getAll();
    return ret;
  }

  dispose() {
    _productController.close();
  }
}
