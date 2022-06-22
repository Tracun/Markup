import 'dart:async';
import 'package:calcular_preco_venda/objects/Rateio.dart';
import 'package:calcular_preco_venda/services/DB/RateioDAO.dart';

class RateioBloc {
  //Get instance of the Repository
  final _rateioDAO = RateioDAO();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _rateioController = StreamController<List<Rateio>>.broadcast();

  get rateios => _rateioController.stream;

  RateioBloc() {
    getAll();
  }

  getAll() async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _rateioController.sink.add(await _rateioDAO.getAll());
  }

  Future<int> newRateio(Rateio rateio) async {
    var ret = await _rateioDAO.insert(rateio);
    getAll();
    return ret;
  }

  Future<dynamic> updateRateio(Rateio rateio) async {
    var ret = await _rateioDAO.update(rateio);
    getAll();
    return ret;
  }

  Future<int> deleteById(int id) async {
    var ret = await _rateioDAO.delete(id);
    getAll();
    return ret;
  }

  Future<Rateio?> getById(int id) async {
    var ret = await _rateioDAO.getById(id);
    return ret;
  }

  dispose() {
    _rateioController.close();
  }
}
