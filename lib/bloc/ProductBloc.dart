import 'dart:async';

import 'package:calcular_preco_venda/models/BasicProductModel.dart';
import 'package:calcular_preco_venda/objects/Product.dart';

class ProductBloc {
  //Get instance of the Repository
  final _productModel = BasicProductDAO();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _productController = StreamController<List<Product>>.broadcast();

  get products => _productController.stream;

  ProductBloc() {
    getAll();
  }

  getAll() async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _productController.sink.add(await _productModel.getAll());
  }

  Future<int> newProduct(Product product) async {
    var ret = await _productModel.insert(product);
    getAll();
    return ret;
  }

  Future<int> updateProduct(Product product) async {
    var ret = await _productModel.update(product);
    getAll();
    return ret;
  }

  Future<int> deleteById(int id) async {
    var ret = await _productModel.delete(id);
    getAll();
    return ret;
  }

  dispose() {
    _productController.close();
  }
}
