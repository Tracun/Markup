import 'dart:developer';

import 'package:calcular_preco_venda/services/DB/GenericModel.dart';
import 'package:calcular_preco_venda/objects/Unidade.dart';

class UnidadeDAO {
  final GenericModel _genericModel = GenericModel("Unidade");

  Future<int> insert(Unidade unidade) async {
    log("INSERINDO Unidade NO GENERIC");
    var key = await _genericModel.insert(unidade.toMap());
    // Insere o id do produto criado e atualiza
    unidade.id = key;
    log("ID DO Unidade INSERIDO: ${key}");
    update(unidade);
    return key;
  }

  Future update(Unidade unidade) async {
    log("ATUALIZANDO Unidade NO GENERIC");
    await _genericModel.update(unidade.toMap());
  }

  Future delete(int unidadeId) async {
    var ret = await _genericModel.delete(unidadeId);
    log('RETORNO DELETE Unidade GENERIC: $ret');
  }

  Future<List<Unidade>> getAll() async {
    final snapshots = await _genericModel.getAllUnidades();
    log("GENERIC Unidade - LENGHT: ${snapshots.length}");
    return snapshots;
  }

  Future<Unidade?> getById(unidadeId) async {
    return await _genericModel.getUnidadeById(unidadeId);
  }
}
