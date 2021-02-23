import 'dart:developer';

import 'package:calcular_preco_venda/services/DB/GenericModel.dart';
import 'package:calcular_preco_venda/objects/Rateio.dart';

class RateioDAO {
  final GenericModel _genericModel = GenericModel("rateio");

  Future<int> insert(Rateio rateio) async {
    log("INSERINDO RATEIO NO GENERIC");
    var key = await _genericModel.insert(rateio.toMap());
    // Insere o id do produto criado e atualiza
    rateio.id = key;
    log("ID DO RATEIO INSERIDO: ${key}");
    update(rateio);
    return key;
  }

  Future<dynamic> update(Rateio rateio) async {
    log("ATUALIZANDO RATEIO NO GENERIC");
    return await _genericModel.update(rateio.toMap());
  }

  Future<dynamic> delete(int rateioId) async {
    var ret = await _genericModel.delete(rateioId);
    log('RETORNO DELETE RATEIO GENERIC: $ret');
    return ret;
  }

  Future<List<Rateio>> getAll() async {
    final snapshots = await _genericModel.getAllRateios();
    log("GENERIC RATEIO - LENGHT: ${snapshots.length}");
    return snapshots;
  }

  Future<Rateio> getById(rateioId) async {
    return await _genericModel.getRateioById(rateioId);
  }
}
