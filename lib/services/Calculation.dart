import 'dart:developer';

import 'package:calcular_preco_venda/bloc/DespesaAdmBloc.dart';
import 'package:calcular_preco_venda/bloc/ImpostoBloc.dart';
import 'package:calcular_preco_venda/bloc/InsumoBloc.dart';
import 'package:calcular_preco_venda/bloc/RateioBloc.dart';
import 'package:calcular_preco_venda/bloc/TempoFabBloc.dart';
import 'package:calcular_preco_venda/objects/DespesaAdm.dart';
import 'package:calcular_preco_venda/objects/Imposto.dart';
import 'package:calcular_preco_venda/objects/Insumo.dart';
import 'package:calcular_preco_venda/objects/Product.dart';
import 'package:calcular_preco_venda/objects/ProductCom.dart';
import 'package:calcular_preco_venda/objects/Rateio.dart';
import 'package:calcular_preco_venda/objects/TempoFab.dart';

class Calculation {
  var _valorTotalDespesa = 0.0;
  var _valorTotalImposto = 0.0;
  var _valorTotalInsumo = 0.0;
  var _valorTotalRateio = 0.0;
  var _valorTotalTempFab = 0.0;

  //Verifica se a soma dos impostos/lucro não excede 100%
  static bool isMoreThanOneHundred(Product produto) {
    return (produto.imp1 !+
            produto.imp2! +
            produto.encargo! +
            produto.comissao! +
            produto.outros! +
            produto.lucro!) >
        100;
  }

  double calcularMarkupFora(Product produto) {
    double markupFora;

    double impostos = produto.imp1 !+ produto.imp2!;

    // Soma dos impostos, encargos, neste caso, não somamos a porcentagem do lucro
    markupFora =
        100 - (impostos + produto.encargo! + produto.comissao! + produto.outros!);

    return markupFora;
  }

  double calcularMarkupDentro(Product produto) {
    double markupDentro;

    double impostos = produto.imp1 !+ produto.imp2!;

    // Soma dos impostos, encargos, *neste caso, somamos a porcentagem do lucro.
    markupDentro = 100 -
        (impostos +
            produto.encargo! +
            produto.comissao! +
            produto.outros! +
            produto.lucro!);

    return markupDentro;
  }

  double calcularPrecoFora(Product produto) {
    //Se a soma dos impostos mais que 100, retorna erro -333, preço não pode ser calculado
    if (isMoreThanOneHundred(produto)) return -333;

    double preco;

    preco = ((produto.custo !+ (produto.custo !* produto.custoIndireto! / 100)) +
            (produto.custo !+ (produto.custo !* produto.custoIndireto! / 100)) *
                produto.lucro! /
                100) /
        calcularMarkupFora(produto) *
        100;

    return preco;
  }

  double calcularPrecoDentro(Product produto) {
    //Se a soma dos impostos mais que 100, retorna erro -333, preço não pode ser calculado
    if (isMoreThanOneHundred(produto)) return -333;

    double preco;

    preco = (produto.custo !+ (produto.custo !* produto.custoIndireto! / 100)) /
        calcularMarkupDentro(produto) *
        100;

    return preco;
  }

  Future<Map<String, double>> calcularPrecoVendaMarkup(
      ProductCom productCom) async {

    // Custo do produto total
    var custoTotal = await calcularCustoTotal(productCom);

    // 100 / [ 100 – ( DV + DF + LP ) ].
    var dv = _valorTotalImposto + productCom.comissao!;
    var df = productCom.custoIndireto;
    var lp = productCom.lucro;

    //Verifica se a soma das porcentagens não excede 100%
    if (dv + df! + lp! > 100) return {'pv': -333, 'custoTotal': -333};

    log("CUSTO TOTAL: $custoTotal");
    var markup = 100 / (100 - (dv + df + lp));

    log("MARKUP: $markup");

    var pv = custoTotal * markup;

    log("PRECO VENDA: $pv");

    log("Despesas: $_valorTotalDespesa");
    log("Imposto: $_valorTotalImposto");
    log("Insumo: $_valorTotalInsumo");
    log("Rateio: $_valorTotalRateio");
    log("TempFab: $_valorTotalTempFab");

    return {'pv': pv, 'custoTotal': custoTotal};
  }

  Future<double> calcularCustoTotal(ProductCom productCom) async {
    await calcularValorDespesas(productCom.despesaAdm!);
    await calcularValorImposto(productCom.impostos!);
    await calcularValorInsumo(productCom.insumos!);
    await calcularValorRateio(productCom.rateio!);
    await calcularValorTempFab(productCom.tempoFab!);

    return productCom.custo !+
        _valorTotalRateio +
        _valorTotalTempFab +
        _valorTotalInsumo +
        _valorTotalDespesa;
  }

  Future<void> calcularValorDespesas(
      List<DespesaAdmList> despesaAdmList) async {
    DespesaAdmBloc despesaAdmBloc = new DespesaAdmBloc();
    DespesaAdm? despesa;

    for (DespesaAdmList d in despesaAdmList) {
      despesa = await despesaAdmBloc.getById(d.id);
      despesa != null ? _valorTotalDespesa += despesa.valor !* d.quant : 0.0;
    }
  }

  Future<void> calcularValorImposto(List<int> impostoList) async {
    ImpostoBloc impostoBloc = new ImpostoBloc();
    Imposto? imposto;

    for (int impID in impostoList) {
      imposto = await impostoBloc.getById(impID);
      imposto != null ? _valorTotalImposto += imposto.porcentagem! : 0.0;
    }
  }

  Future<void> calcularValorInsumo(List<InsumoList> insumoList) async {
    InsumoBloc insumoBloc = new InsumoBloc();
    Insumo? insumo;

    for (InsumoList i in insumoList) {
      insumo = await insumoBloc.getById(i.id);
      insumo != null
          ? _valorTotalInsumo += insumo.valorUnitario !* i.quant
          : 0.0;
    }
  }

  Future<void> calcularValorRateio(List<RateioList> rateioList) async {
    RateioBloc rateioBloc = new RateioBloc();
    Rateio? rateio;

    for (RateioList rat in rateioList) {
      rateio = await rateioBloc.getById(rat.id);
      rateio != null
          ? _valorTotalRateio += rateio.valor !* (rat.porcentagemRateio / 100)
          : 0.0;
    }
  }

  Future<void> calcularValorTempFab(List<TempoFabList> tempFabList) async {
    TempoFabBloc tempFabBloc = new TempoFabBloc();
    TempoFab? tempFab;

    for (TempoFabList temp in tempFabList) {
      tempFab = await tempFabBloc.getById(temp.id);
      tempFab != null
          ? _valorTotalTempFab += tempFab.valorHora !* temp.quant
          : 0.0;
    }
  }

  restartValues() {
    _valorTotalDespesa = 0.0;
    _valorTotalImposto = 0.0;
    _valorTotalInsumo = 0.0;
    _valorTotalRateio = 0.0;
    _valorTotalTempFab = 0.0;
  }
}
