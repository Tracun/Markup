import 'dart:developer';
import 'dart:io';
import 'package:calcular_preco_venda/Repository/ProductRepository.dart';
import 'package:calcular_preco_venda/bloc/ProductComBloc.dart';
import 'package:calcular_preco_venda/services/DB/InsumoDAO.dart';
import 'package:calcular_preco_venda/models/BasicProductModel.dart';
import 'package:calcular_preco_venda/objects/Insumo.dart';
import 'package:calcular_preco_venda/objects/ProductCom.dart';
import 'package:calcular_preco_venda/services/DB/ProductCompleteDAO.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/utils/ScreenNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class ProductListCompleto extends StatefulWidget {
  createState() => _ProductListAdmState();
}

class _ProductListAdmState extends State<ProductListCompleto> {
  String loadingText;
  final String newProduct = "/newProduct";
  final String editProduct = "/editProduct";

  ProductCompleteDAO _productDAO = ProductCompleteDAO();
  ProductCompleteBloc _productCompleteBloc = ProductCompleteBloc();
  InsumoDAO insumoDAO = InsumoDAO();
  List<ProductCom> _products = [];

  //Allows products to be dismissable horizontally
  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  void insertProductFromOlderVersion() async =>
      await BasicProductDAO().getProductsFromOlderVersion();

  @override
  void initState() {
    super.initState();
    insertProductFromOlderVersion();
    _loadProducts();
  }

  Widget bottomNavigationBar() {
    return BottomAppBar(
      color: MyColors().buttonColor(),
      child: Container(
        height: 40,
      ),
      shape: CircularNotchedRectangle(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: MyColors().appBarColor(),
        automaticallyImplyLeading: true,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("Produto Completo"),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                Messages().showAlertDialog(context, "Produto Completo",
                    "Crie o preço de venda e custo de seus produtos/serviços, adicionando os insumos e itens necessários para a formação de custo e preço de venda.\nEx.:\n" + 
                    "\nNome: Coxinha\n"+
                    "Custo: R\$ 0,50\n"+
                    "Lucro: 45 %\n"+
                    "Custo indireto: 0 %\n"+
                    "Comissão: 0 \n\n"+
                    "Despesas Adm:\n"+
                    "Cozinheiro - 0,16/Horas (equivale a 10 minutos)\n"+
                    "\nImpostos:\n"+
                    "IVA - 10 %\n"+
                    "\nInsumos:\n"+
                    "Farinha - 0,50 (supondo que o cadastro da farinha seja de 1kg, 0,50 equivale à 50g)\n"+
                    "\nLeite - 0,50 (supondo que o cadastro do leite seja de 1 litro, 0,50 equivale à 50ml)\n"+
                    "\nFrango - 0,50 (supondo que o cadastro do frango seja de 1kg, 0,80 equivale à 80g)\n"+
                    "\nRateio:\n"+
                    "Oléo fritura - 1% (Pego 1% do valor do óleo de fritura cadastrado)\n"+
                    "\nTempo Fab:\n"+
                    "Fazer coxinha - 0,05/Horas (Equivale a 3 minutos)\n",
                    buttonText: "Entendi");
              }),
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                _loadProducts();
              }),
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
          child: Container(
            child: getProductWidget(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        backgroundColor: MyColors().buttonColor(),
        onPressed: () {
          ScreenNavigator().newproductComScreen(context, _productCompleteBloc);
        },
        child: new Icon(Icons.add),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget buildProductList(BuildContext context, int index) {
    ProductCom product = _products[index];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Material(
          color: Colors.white,
          elevation: 16.0,
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Color.fromRGBO(37, 143, 98, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Color.fromRGBO(37, 143, 98, 1),
                    child: ClipOval(
                      child: new SizedBox(
                        width: 120.0,
                        height: 120.0,
                        child: (_products[index].uriImg != null)
                            ? Image.file(
                                new File(_products[index].uriImg),
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                "assets/noImage.gif",
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              // TITLLE
              Flexible(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 6.0),
                          child: Container(
                              child: Text(
                            product.nome,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          )),
                        ),
                        // Prices
                        Container(
                          child: Text(
                            "Preço venda: R\$ ${product.precoVendaMarkup.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Custo total: R\$ ${product.custoTotalCalculado.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Lucro Bruto: R\$ ${(product.precoVendaMarkup - product.custoTotalCalculado).toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getProductWidget() {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (_products != null) {
      /*Also handles whenever there's stream
      but returned returned 0 records of product from DB.
      If that the case show user that you have empty products
      */
      return _products.length != 0
          ? new ListView.builder(
              itemCount: _products.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  background: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Excluir",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                  onDismissed: (direction) {
                    Messages().showYesNoDialog(
                        context,
                        "Exclusão",
                        "Deseja excluir o item ${_products[index].nome}?",
                        null, () async {
                      // Sim
                      _deleteProducts(_products[index].id);
                      Navigator.of(context).pop();
                    }, () {
                      // Não
                      _loadProducts();
                      Navigator.of(context).pop();
                    });
                  },
                  direction: _dismissDirection,
                  key: UniqueKey(),
                  child: GestureDetector(
                    child: buildProductList(context, index),
                    onTap: () {
                      ScreenNavigator().updateproductComScreen(
                          context, _products[index], _productCompleteBloc);
                    },
                  ),
                );
              })
          : Container(
              child: Center(
              //this is used whenever there 0 products
              //in the data base
              child: noTodoMessageWidget(),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    //pull products again
    _loadProducts();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Carregando...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget noTodoMessageWidget() {
    return Container(
      child: Text(
        "Adicione um produto COMPLETO...",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }

  _loadProducts() async {
    _products = await _productDAO.getAllProducts();
    setState(() {});
    log('products lenght: ${_products.length}');
  }

  _deleteProducts(int id) async {
    await _productCompleteBloc.deleteById(id);
    setState(() {});
  }
}
