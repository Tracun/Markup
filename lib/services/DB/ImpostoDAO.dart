import 'dart:developer';

import 'package:calcular_preco_venda/services/DB/GenericModel.dart';
import 'package:calcular_preco_venda/objects/Imposto.dart';

class ImpostoDAO {
  final GenericModel _genericModel = GenericModel("Imposto");

  Future<int> insert(Imposto imposto) async {
    log("INSERINDO Imposto NO GENERIC");
    var key = await _genericModel.insert(imposto.toMap());
    // Insere o id do produto criado e atualiza
    imposto.id = key;
    log("ID DO Imposto INSERIDO: ${key}");
    update(imposto);
    return key;
  }

  Future update(Imposto imposto) async {
    log("ATUALIZANDO Imposto NO GENERIC");
    await _genericModel.update(imposto.toMap());
  }

  Future delete(int impostoId) async {
    var ret = await _genericModel.delete(impostoId);
    log('RETORNO DELETE Imposto GENERIC: $ret');
  }

  Future<List<Imposto>> getAll() async {
    final snapshots = await _genericModel.getAllImpostos();
    log("GENERIC Imposto - LENGHT: ${snapshots.length}");
    return snapshots;
  }

  Future<Imposto> getById(impostoId) async {
    return await _genericModel.getImpostoById(impostoId);
  }
}
