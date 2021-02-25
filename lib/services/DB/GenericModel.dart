import 'dart:developer';

import 'package:calcular_preco_venda/Repository/GenericRepository.dart';
import 'package:calcular_preco_venda/objects/DespesaAdm.dart';
import 'package:calcular_preco_venda/objects/Imposto.dart';
import 'package:calcular_preco_venda/objects/Insumo.dart';
import 'package:calcular_preco_venda/objects/ProductCom.dart';
import 'package:calcular_preco_venda/objects/Rateio.dart';
import 'package:calcular_preco_venda/objects/TempoFab.dart';
import 'package:calcular_preco_venda/objects/Unidade.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

class GenericModel implements GenericRepository {
  String _storeName;
  GenericModel(
    this._storeName,
  ) {
    init();
  }

  Database _database;
  StoreRef _store;

  @override
  init() {
    _database = GetIt.I.get();
    _store = intMapStoreFactory.store(_storeName);
  }

  @override
  Future<int> insert(dynamic objectMap) async {
    var key = await _store.add(_database, objectMap);
    // Insere o id do produto criado e atualiza
    objectMap['id'] = key;
    update(objectMap);
    return key;
  }

  @override
  Future update(dynamic objectMap) async {
    log("UPDATE GENERIC");
    return await _store.record(objectMap['id']).update(_database, objectMap);
  }

  @override
  Future delete(int id) async {
    var ret = await _store.record(id).delete(_database);
    log('RETORNO DELETE: $ret');
  }

  @override
  Future<List<ProductCom>> getAllProducts() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => ProductCom().fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<Insumo>> getAllInsumos() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Insumo.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<Rateio>> getAllRateios() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Rateio.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<TempoFab>> getAllTempoFabs() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => TempoFab.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<Unidade>> getAllUnidades() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Unidade.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<Imposto>> getAllImpostos() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Imposto.fromMap(snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<DespesaAdm>> getAllDespesaAdm() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => DespesaAdm().fromMap(snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<ProductCom> getProductById(int productId) async {
    var product = await _store.record(productId).get(_database);

    return product != null ? ProductCom().fromMap(null, product) : null;
  }

  @override
  Future<Insumo> getInsumoById(int insumoId) async {
    var insumo = await _store.record(insumoId).get(_database);

    return insumo != null ? Insumo().fromMap(insumo) : null;
  }

  @override
  Future<Rateio> getRateioById(int rateioId) async {
    var rateio = await _store.record(rateioId).get(_database);

    return rateio != null ? Rateio().fromMap(rateio) : null;
  }

  @override
  Future<TempoFab> getTempoFabById(int tempoFabId) async {
    var tempoFab = await _store.record(tempoFabId).get(_database);

    return tempoFab != null ? TempoFab().fromMap(tempoFab) : null;
  }

  @override
  Future<Unidade> getUnidadeById(int unidadeId) async {
    var unidade = await _store.record(unidadeId).get(_database);

    return unidade != null ? Unidade().fromMap(unidade) : null;
  }

  @override
  Future<Imposto> getImpostoById(int impostoId) async {
    var imposto = await _store.record(impostoId).get(_database);

    return imposto != null ? Imposto().fromMap(imposto) : null;
  }

  @override
  Future<DespesaAdm> getDespesaAdmById(int impostoId) async {
    var imposto = await _store.record(impostoId).get(_database);

    return imposto != null ? DespesaAdm().fromMap(imposto) : null;
  }
}
