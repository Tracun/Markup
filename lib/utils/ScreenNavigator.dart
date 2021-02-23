import 'package:calcular_preco_venda/bloc/DespesaAdmBloc.dart';
import 'package:calcular_preco_venda/bloc/ImpostoBloc.dart';
import 'package:calcular_preco_venda/bloc/InsumoBloc.dart';
import 'package:calcular_preco_venda/bloc/ProductBloc.dart';
import 'package:calcular_preco_venda/bloc/ProductComBloc.dart';
import 'package:calcular_preco_venda/bloc/RateioBloc.dart';
import 'package:calcular_preco_venda/bloc/TempoFabBloc.dart';
import 'package:calcular_preco_venda/objects/DespesaAdm.dart';
import 'package:calcular_preco_venda/objects/Imposto.dart';
import 'package:calcular_preco_venda/objects/Insumo.dart';
import 'package:calcular_preco_venda/objects/Product.dart';
import 'package:calcular_preco_venda/objects/ProductCom.dart';
import 'package:calcular_preco_venda/objects/Rateio.dart';
import 'package:calcular_preco_venda/objects/TempoFab.dart';
import 'package:flutter/cupertino.dart';

class ScreenNavigator {
  final _newProduct = "/newProduct";
  final _productList = "/productList";
  final _editProduct = "/editProduct";

  final _newProductCom = "/newProductCom";
  final _productComList = "/productComList";
  final _editProductCom = "/editProductCom";

  final _insumoList = "/insumoList";
  final _newInsumo = "/newInsumo";
  final _editInsumo = "/editInsumo";

  final _rateioList = "/rateioList";
  final _newRateio = "/newRateio";
  final _editRateio = "/editRateio";

  final _impostoList = "/impostoList";
  final _newImposto = "/newImposto";
  final _editImposto = "/editImposto";

  final _despesaAdmList = "/despesaAdmList";
  final _newDespesaAdm = "/newDespesaAdm";
  final _editDespesaAdm = "/editDespesaAdm";

  final _tempoFabList = "/tempoFabList";
  final _newTempoFab = "/newTempoFab";
  final _editTempoFab = "/editTempoFab";

  void productListScreen(context) {
    Navigator.pushNamed(
      context,
      _productList,
    );
  }

  void newProductScreen(context, ProductBloc productBloc) {
    Navigator.pushNamed(
      context,
      _newProduct,
      arguments: {"productBloc": productBloc},
    );
  }

  void updateProduct(context, Product product, ProductBloc productBloc) {
    Navigator.pushNamed(
      context,
      _editProduct,
      arguments: {"product": product, "productBloc": productBloc},
    );
  }

  void insumoListScreen(context) {
    Navigator.pushNamed(
      context,
      _insumoList,
    );
  }

  void newIsumoScreen(context, InsumoBloc insumoBloc) {
    Navigator.pushNamed(
      context,
      _newInsumo,
      arguments: {"insumoBloc": insumoBloc},
    );
  }

  void updateInsumo(context, Insumo insumo, InsumoBloc insumoBloc) {
    Navigator.pushNamed(
      context,
      _editInsumo,
      arguments: {"insumo": insumo, "insumoBloc": insumoBloc},
    );
  }

  void rateioListScreen(context) {
    Navigator.pushNamed(
      context,
      _rateioList,
    );
  }

  void newRateioScreen(context, RateioBloc rateioBloc) {
    Navigator.pushNamed(
      context,
      _newRateio,
      arguments: {"rateioBloc": rateioBloc},
    );
  }

  void updateRateio(context, Rateio rateio, RateioBloc rateioBloc) {
    Navigator.pushNamed(
      context,
      _editRateio,
      arguments: {"rateio": rateio, "rateioBloc": rateioBloc},
    );
  }

  void impostoListScreen(context) {
    Navigator.pushNamed(
      context,
      _impostoList,
    );
  }

  void newImpostoScreen(context, ImpostoBloc impostoBloc) {
    Navigator.pushNamed(
      context,
      _newImposto,
      arguments: {"impostoBloc": impostoBloc},
    );
  }

  void updateImposto(context, Imposto imposto, ImpostoBloc impostoBloc) {
    Navigator.pushNamed(
      context,
      _editImposto,
      arguments: {"imposto": imposto, "impostoBloc": impostoBloc},
    );
  }

  void despesaAdmListScreen(context) {
    Navigator.pushNamed(
      context,
      _despesaAdmList,
    );
  }

  void newDespesaAdmScreen(context, DespesaAdmBloc despesaAdmBloc) {
    Navigator.pushNamed(
      context,
      _newDespesaAdm,
      arguments: {"despesaAdmBloc": despesaAdmBloc},
    );
  }

  void updateDespesaAdm(
      context, DespesaAdm despesaAdm, DespesaAdmBloc despesaAdmBloc) {
    Navigator.pushNamed(
      context,
      _editDespesaAdm,
      arguments: {"despesaAdm": despesaAdm, "despesaAdmBloc": despesaAdmBloc},
    );
  }

  void tempoFabListScreen(context) {
    Navigator.pushNamed(
      context,
      _tempoFabList,
    );
  }

  void newTempoFabScreen(context, TempoFabBloc tempoFabBloc) {
    Navigator.pushNamed(
      context,
      _newTempoFab,
      arguments: {"tempoFabBloc": tempoFabBloc},
    );
  }

  void updateTempoFab(context, TempoFab tempoFab, TempoFabBloc tempoFabBloc) {
    Navigator.pushNamed(
      context,
      _editTempoFab,
      arguments: {"tempoFab": tempoFab, "tempoFabBloc": tempoFabBloc},
    );
  }

  void newproductComScreen(context, ProductCompleteBloc productCompleteBloc) {
    Navigator.pushNamed(
      context,
      _newProductCom,
      arguments: {"productCompleteBloc": productCompleteBloc},
    );
  }

  void updateproductComScreen(context, ProductCom product, ProductCompleteBloc productCompleteBloc) {
    Navigator.pushNamed(
      context,
      _editProductCom,
      arguments: {"product": product, "productCompleteBloc": productCompleteBloc},
    );
  }

  void productComListScreen(context) {
    Navigator.pushNamed(
      context,
      _productComList,
    );
  }

  void productCom(context) {
    Navigator.pushNamed(
      context,
      "/productCom",
    );
  }
}
