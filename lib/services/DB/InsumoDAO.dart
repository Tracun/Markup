import 'dart:developer';

import 'package:calcular_preco_venda/services/DB/GenericModel.dart';
import 'package:calcular_preco_venda/objects/Insumo.dart';

class InsumoDAO {
  final GenericModel _genericModel = GenericModel("insumo");

  Future<int> insert(Insumo insumo) async {
    log("INSERINDO INSUMO NO GENERIC");
    var key = await _genericModel.insert(insumo.toMap());
    // Insere o id do produto criado e atualiza
    insumo.id = key;
    log("ID DO INSUMO INSERIDO: ${key}");
    update(insumo);
    return key;
  }

  Future update(Insumo insumo) async {
    log("ATUALIZANDO INSUMO NO GENERIC");
    return await _genericModel.update(insumo.toMap());
  }

  Future delete(int insumoId) async {
    var ret = await _genericModel.delete(insumoId);
    log('RETORNO DELETE INSUMO GENERIC: $ret');
  }

  Future<List<Insumo>> getAll() async {
    final snapshots = await _genericModel.getAllInsumos();
    log("GENERIC INSUMO - LENGHT: ${snapshots.length}");
    return snapshots;
  }

  Future<Insumo> getById(insumoId) async {
    return await _genericModel.getInsumoById(insumoId);
  }
}
