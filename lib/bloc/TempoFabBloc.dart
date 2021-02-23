import 'dart:async';
import 'package:calcular_preco_venda/objects/TempoFab.dart';
import 'package:calcular_preco_venda/services/DB/TempoFabDAO.dart';

class TempoFabBloc {
  //Get instance of the Repository
  final _tempoFabDAO = TempoFabDAO();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _tempoFabController = StreamController<List<TempoFab>>.broadcast();

  get tempoFabs => _tempoFabController.stream;

  TempoFabBloc() {
    getAll();
  }

  getAll() async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _tempoFabController.sink.add(await _tempoFabDAO.getAll());
  }

  Future<int> newTempoFab(TempoFab tempoFab) async {
    var ret = await _tempoFabDAO.insert(tempoFab);
    getAll();
    return ret;
  }

  Future<dynamic> updateTempoFab(TempoFab tempoFab) async {
    var ret = await _tempoFabDAO.update(tempoFab);
    getAll();
    return ret;
  }

  Future<int> deleteById(int id) async {
    var ret = await _tempoFabDAO.delete(id);
    getAll();
    return ret;
  }

    Future<TempoFab> getById(int id) async {
    var ret = await _tempoFabDAO.getById(id);
    return ret;
  }

  dispose() {
    _tempoFabController.close();
  }
}
