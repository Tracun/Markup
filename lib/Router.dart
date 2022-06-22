import 'package:calcular_preco_venda/screens/HomePageScreen.dart';
import 'package:calcular_preco_venda/screens/insert_screens/NewDespesaAdm.dart';
import 'package:calcular_preco_venda/screens/insert_screens/NewImpostoScreen.dart';
import 'package:calcular_preco_venda/screens/insert_screens/NewInsumoScreen.dart';
import 'package:calcular_preco_venda/screens/insert_screens/NewProductCompleteScreen.dart';
import 'package:calcular_preco_venda/screens/insert_screens/NewProductScreen.dart';
import 'package:calcular_preco_venda/screens/insert_screens/NewRateioScreen.dart';
import 'package:calcular_preco_venda/screens/insert_screens/NewTempoFab.dart';
import 'package:calcular_preco_venda/screens/lists_screens/DespesaAdmList.dart';
import 'package:calcular_preco_venda/screens/lists_screens/ImpostoListScreen.dart';
import 'package:calcular_preco_venda/screens/lists_screens/InsumoListScreen.dart';
import 'package:calcular_preco_venda/screens/lists_screens/ProductList.dart';
import 'package:calcular_preco_venda/screens/lists_screens/ProductListCompleto.dart';
import 'package:calcular_preco_venda/screens/lists_screens/RateioListScreen.dart';
import 'package:calcular_preco_venda/screens/lists_screens/TempoFabList.dart';
import 'package:calcular_preco_venda/screens/update_screens/UpdateDespesaAdm.dart';
import 'package:calcular_preco_venda/screens/update_screens/UpdateImpostoScreen.dart';
import 'package:calcular_preco_venda/screens/update_screens/UpdateInsumoScreen.dart';
import 'package:calcular_preco_venda/screens/update_screens/UpdateProductCompleteScreen.dart';
import 'package:calcular_preco_venda/screens/update_screens/UpdateProductScreen.dart';
import 'package:calcular_preco_venda/screens/update_screens/UpdateRateioScreen.dart';
import 'package:calcular_preco_venda/screens/update_screens/UpdateTempoFab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const loginPageRoute = "/";

const newProduct = "/newProduct";
const productList = "/productList";
const editProduct = "/editProduct";

const newProductCom = "/newProductCom";
const productComList = "/productComList";
const editProductCom = "/editProductCom";

const insumoList = "/insumoList";
const newInsumo = "/newInsumo";
const editInsumo = "/editInsumo";

const rateioList = "/rateioList";
const newRateio = "/newRateio";
const editRateio = "/editRateio";

const impostoList = "/impostoList";
const newImposto = "/newImposto";
const editImposto = "/editImposto";

const despesaAdmList = "/despesaAdmList";
const newDespesaAdm = "/newDespesaAdm";
const editDespesaAdm = "/editDespesaAdm";

const tempoFabList = "/tempoFabList";
const newTempoFab = "/newTempoFab";
const editTempoFab = "/editTempoFab";

RouteFactory routes() {
  return (settings) {
    final Object? arguments = settings.arguments;
    Widget screen;

    switch (settings.name) {
      case loginPageRoute:
        screen = HomePageScreen();
        break;
      case newProduct:
        arguments as Map<String, dynamic>;
        screen = NewProductScreen(
          arguments['productBloc'],
        );
        break;
      case productList:
        screen = ProductList();
        break;
      case editProduct:
        arguments as Map<String, dynamic>;
        screen =
            UpdateProductScreen(arguments['product'], arguments['productBloc']);
        break;
      case newProductCom:
        arguments as Map<String, dynamic>;
        screen = NewProductCompleteScreen(arguments['productCompleteBloc']);
        break;
      case productComList:
        screen = ProductListCompleto();
        break;
      case editProductCom:
        arguments as Map<String, dynamic>;
        screen = UpdateProductCompleteScreen(
            arguments['product'], arguments['productCompleteBloc']);
        break;
      case newInsumo:
        arguments as Map<String, dynamic>;
        screen = NewInsumoScreen(
          arguments['insumoBloc'],
        );
        break;
      case insumoList:
        screen = InsumoListScreen();
        break;
      case editInsumo:
        arguments as Map<String, dynamic>;
        screen =
            UpdateInsumoScreen(arguments['insumo'], arguments['insumoBloc']);
        break;
      case newRateio:
        arguments as Map<String, dynamic>;
        screen = NewRateioScreen(
          arguments['rateioBloc'],
        );
        break;
      case rateioList:
        screen = RateioListScreen();
        break;
      case editRateio:
        arguments as Map<String, dynamic>;
        screen = UpdateRateio(arguments['rateio'], arguments['rateioBloc']);
        break;
      case newImposto:
        arguments as Map<String, dynamic>;
        screen = NewImpostoScreen(
          arguments['impostoBloc'],
        );
        break;
      case impostoList:
        screen = ImpostoListScreen();
        break;
      case editImposto:
        arguments as Map<String, dynamic>;
        screen =
            UpdateImpostoScreen(arguments['imposto'], arguments['impostoBloc']);
        break;
      case newDespesaAdm:
        arguments as Map<String, dynamic>;
        screen = NewDespesaAdmScreen(
          arguments['despesaAdmBloc'],
        );
        break;
      case despesaAdmList:
        screen = DespesaAdmListScreen();
        break;
      case editDespesaAdm:
        arguments as Map<String, dynamic>;
        screen = UpdateDespesaAdmScreen(
            arguments['despesaAdm'], arguments['despesaAdmBloc']);
        break;
      case newTempoFab:
        arguments as Map<String, dynamic>;
        screen = NewTempoFabScreen(
          arguments['tempoFabBloc'],
        );
        break;
      case tempoFabList:
        screen = TempoFabListScreen();
        break;
      case editTempoFab:
        arguments as Map<String, dynamic>;
        screen = UpdateTempoFabScreen(
            arguments['tempoFab'], arguments['tempoFabBloc']);
        break;
      default:
        screen = HomePageScreen();
        break;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
