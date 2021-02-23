import 'dart:developer';

import 'package:calcular_preco_venda/services/DB/GenericModel.dart';
import 'package:calcular_preco_venda/objects/TempoFab.dart';

class TempoFabDAO {
  final GenericModel _genericModel = GenericModel("TempoFab");

  Future<int> insert(TempoFab tempoFab) async {
    log("INSERINDO TempoFab NO GENERIC");
    var key = await _genericModel.insert(tempoFab.toMap());
    // Insere o id do produto criado e atualiza
    tempoFab.id = key;
    log("ID DO TempoFab INSERIDO: ${key}");
    update(tempoFab);
    return key;
  }

  Future update(TempoFab tempoFab) async {
    log("ATUALIZANDO TempoFab NO GENERIC");
    await _genericModel.update(tempoFab.toMap());
  }

  Future delete(int tempoFabId) async {
    var ret = await _genericModel.delete(tempoFabId);
    log('RETORNO DELETE TempoFab GENERIC: $ret');
  }

  Future<List<TempoFab>> getAll() async {
    final snapshots = await _genericModel.getAllTempoFabs();
    log("GENERIC TempoFab - LENGHT: ${snapshots.length}");
    return snapshots;
  }

  Future<TempoFab> getById(tempoFabId) async {
    return await _genericModel.getTempoFabById(tempoFabId);
  }
}
