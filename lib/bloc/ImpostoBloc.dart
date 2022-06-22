import 'dart:async';
import 'package:calcular_preco_venda/objects/Imposto.dart';
import 'package:calcular_preco_venda/services/DB/ImpostoDAO.dart';

class ImpostoBloc {
  //Get instance of the Repository
  final _impostoDAO = ImpostoDAO();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _impostoController = StreamController<List<Imposto>>.broadcast();

  get impostos => _impostoController.stream;

  ImpostoBloc() {
    getAll();
  }

  getAll() async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _impostoController.sink.add(await _impostoDAO.getAll());
  }

  Future<int> newImposto(Imposto imposto) async {
    var ret = await _impostoDAO.insert(imposto);
    getAll();
    return ret;
  }

  Future<dynamic> updateImposto(Imposto imposto) async {
    var ret = await _impostoDAO.update(imposto);
    getAll();
    return ret;
  }

  Future<int> deleteById(int id) async {
    var ret = await _impostoDAO.delete(id);
    getAll();
    return ret;
  }

  Future<Imposto?> getById(int id) async {
    var ret = await _impostoDAO.getById(id);
    return ret;
  }

  dispose() {
    _impostoController.close();
  }
}
