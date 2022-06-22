import 'dart:async';
import 'package:calcular_preco_venda/objects/Insumo.dart';
import 'package:calcular_preco_venda/services/DB/InsumoDAO.dart';

class InsumoBloc {
  //Get instance of the Repository
  final _insumoDAO = InsumoDAO();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _insumoController = StreamController<List<Insumo>>.broadcast();

  get insumos => _insumoController.stream;

  InsumoBloc() {
    getAll();
  }

  getAll() async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _insumoController.sink.add(await _insumoDAO.getAll());
  }

  Future<int> newInsumo(Insumo insumo) async {
    var ret = await _insumoDAO.insert(insumo);
    getAll();
    return ret;
  }

  Future<dynamic> updateInsumo(Insumo insumo) async {
    var ret = await _insumoDAO.update(insumo);
    getAll();
    return ret;
  }

  Future<int> deleteById(int id) async {
    var ret = await _insumoDAO.delete(id);
    getAll();
    return ret;
  }

  Future<Insumo?> getById(int id) async {
    var ret = await _insumoDAO.getById(id);
    return ret;
  }

  dispose() {
    _insumoController.close();
  }
}
