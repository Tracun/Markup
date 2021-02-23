import 'dart:async';
import 'package:calcular_preco_venda/objects/DespesaAdm.dart';
import 'package:calcular_preco_venda/services/DB/DespesaAdmDAO.dart';

class DespesaAdmBloc {
  //Get instance of the Repository
  final _despesaAdmDAO = DespesaAdmDAO();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _despesaAdmController = StreamController<List<DespesaAdm>>.broadcast();

  get despesaAdms => _despesaAdmController.stream;

  DespesaAdmBloc() {
    getAll();
  }

  getAll() async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _despesaAdmController.sink.add(await _despesaAdmDAO.getAll());
  }

  Future<int> newDespesaAdm(DespesaAdm despesaAdm) async {
    var ret = await _despesaAdmDAO.insert(despesaAdm);
    getAll();
    return ret;
  }

  Future<dynamic> updateDespesaAdm(DespesaAdm despesaAdm) async {
    var ret = await _despesaAdmDAO.update(despesaAdm);
    getAll();
    return ret;
  }

  Future<int> deleteById(int id) async {
    var ret = await _despesaAdmDAO.delete(id);
    getAll();
    return ret;
  }

  Future<DespesaAdm> getById(int id) async {
    var ret = await _despesaAdmDAO.getById(id);
    return ret;
  }

  dispose() {
    _despesaAdmController.close();
  }
}
