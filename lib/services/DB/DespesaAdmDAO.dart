import 'dart:developer';

import 'package:calcular_preco_venda/services/DB/GenericModel.dart';
import 'package:calcular_preco_venda/objects/DespesaAdm.dart';

class DespesaAdmDAO {
  final GenericModel _genericModel = GenericModel("despesaAdm");

  Future<int> insert(DespesaAdm despesaAdm) async {
    log("INSERINDO DESPESA_ADM NO GENERIC");
    var key = await _genericModel.insert(despesaAdm.toMap());
    // Insere o id do produto criado e atualiza
    despesaAdm.id = key;
    log("ID DO DESPESA_ADM INSERIDO: ${key}");
    update(despesaAdm);
    return key;
  }

  Future<dynamic> update(DespesaAdm despesaAdm) async {
    log("ATUALIZANDO DESPESA_ADM NO GENERIC");
    return await _genericModel.update(despesaAdm.toMap());
  }

  Future<dynamic> delete(int despesaAdmId) async {
    var ret = await _genericModel.delete(despesaAdmId);
    log('RETORNO DELETE DESPESA_ADM GENERIC: $ret');
    return ret;
  }

  Future<List<DespesaAdm>> getAll() async {
    final snapshots = await _genericModel.getAllDespesaAdm();
    log("GENERIC DESPESA_ADM - LENGHT: ${snapshots.length}");
    return snapshots;
  }

  Future<DespesaAdm> getById(despesaAdmId) async {
    return await _genericModel.getDespesaAdmById(despesaAdmId);
  }
}
