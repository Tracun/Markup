import 'package:calcular_preco_venda/objects/DespesaAdm.dart';
import 'package:calcular_preco_venda/objects/Insumo.dart';
import 'package:calcular_preco_venda/objects/Rateio.dart';
import 'package:calcular_preco_venda/objects/TempoFab.dart';

class ProductCom {
  int id;
  String nome;
  double custo;
  double lucro;
  double precoVendaMarkup;
  double custoTotalCalculado;
  double precoVendaFora;
  double precoVendaDentro;
  double custoIndireto;
  double comissao;
  String uriImg;

  List<InsumoList> insumos;
  List<TempoFabList> tempoFab;
  List<DespesaAdmList> despesaAdm;
  List<RateioList> rateio;
  List<int> impostos;

  ProductCom(
      {this.id,
      this.nome,
      this.custo,
      this.lucro,
      this.custoTotalCalculado,
      this.precoVendaMarkup,
      this.precoVendaFora,
      this.precoVendaDentro,
      this.custoIndireto,
      this.comissao,
      this.uriImg,
      this.insumos,
      this.tempoFab,
      this.despesaAdm,
      this.rateio,
      this.impostos});

  ProductCom fromMap(int id, Map<dynamic, dynamic> json) {
    var insumosAux;
    var tempoFabAux;
    var despesaAdmAux;
    var rateioAux;
    var impostoAux;

    if (json["insumos"] != null) {
      insumosAux = new List<InsumoList>();
      json["insumos"].forEach((v) {
        insumosAux.add(InsumoList(v['id'], v['quant'], v['name']));
      });
    }

    if (json["tempoFab"] != null) {
      tempoFabAux = new List<TempoFabList>();
      json["tempoFab"].forEach((v) {
        tempoFabAux.add(TempoFabList(v['id'], v['quant'], v['descricao']));
      });
    }

    if (json["despesaAdm"] != null) {
      despesaAdmAux = new List<DespesaAdmList>();
      json["despesaAdm"].forEach((v) {
        despesaAdmAux.add(DespesaAdmList(v['id'], v['quant'], v['descricao']));
      });
    }

    if (json["rateio"] != null) {
      rateioAux = new List<RateioList>();
      json["rateio"].forEach((v) {
        rateioAux.add(RateioList(v['id'], v['porcentagemRateio'], v['descricao']));
      });
    }

    if (json["impostos"] != null) {
      impostoAux = new List<int>();
      json["impostos"].forEach((v) {
        impostoAux.add(v['id']);
      });
    }

    return ProductCom(
      id: json['id'],
      nome: json['nome'],
      custo: json['custo'],
      custoTotalCalculado: json['custoTotalCalculado'],
      lucro: json['lucro'],
      custoIndireto: json['custoIndireto'],
      comissao: json['comissao'],
      precoVendaMarkup: json['precoVendaMarkup'],
      precoVendaFora: json['precoVendaFora'],
      precoVendaDentro: json['precoVendaDentro'],
      uriImg: json['uriImg'],
      insumos: insumosAux,
      tempoFab: tempoFabAux,
      despesaAdm: despesaAdmAux,
      rateio: rateioAux,
      impostos: impostoAux,
    );
  }

  // factory ProductCom.fromMap(int id, Map<String, dynamic> json) =>
  //     new ProductCom(
  //       id: json['id'],
  //       nome: json['nome'],
  //       custo: json['custo'],
  //       lucro: json['lucro'],
  //       precoVendaFora: json['precoVendaFora'],
  //       precoVendaDentro: json['precoVendaDentro'],
  //       uriImg: json['uriImg'],
  //       insumos: json['insumos'],
  //       tempoFab: json['tempoFab'],
  //       despesaAdm: json['despesaAdm'],
  //       rateio: json['rateio'],
  //     );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'nome': this.nome,
      'custo': this.custo,
      'lucro': this.lucro,
      'custoTotalCalculado': this.custoTotalCalculado,
      'custoIndireto': this.custoIndireto,
      'comissao': this.comissao,
      'precoVendaMarkup': this.precoVendaMarkup,
      'precoVendaFora': this.precoVendaFora,
      'precoVendaDentro': this.precoVendaDentro,
      'uriImg': this.uriImg,
      'insumos': this.insumos != null
          ? this.insumos.map((v) => v.toMap()).toList()
          : null,
      'tempoFab': this.tempoFab != null
          ? this.tempoFab.map((v) => v.toMap()).toList()
          : null,
      'despesaAdm': this.despesaAdm != null
          ? this.despesaAdm.map((v) => v.toMap()).toList()
          : null,
      'rateio': this.rateio != null
          ? this.rateio.map((v) => v.toMap()).toList()
          : null,
      'impostos': this.impostos != null ? listToMap(this.impostos) : null,
    };
  }

  List<Map<String, int>> listToMap(List<int> list) {
    var result = list.map((id) {
      return {"id": id};
    }).toList();

    return result;
  }
}
