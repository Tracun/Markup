import 'dart:developer';
import 'dart:io';
import 'package:calcular_preco_venda/bloc/ProductBloc.dart';
import 'package:calcular_preco_venda/models/BasicProductModel.dart';
import 'package:calcular_preco_venda/objects/Product.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/utils/ScreenNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductList extends StatefulWidget {
  createState() => _ProductListAdmState();
}

class _ProductListAdmState extends State<ProductList> {
  List<Product> _list;
  String loadingText;
  final String newProduct = "/newProduct";
  final String editProduct = "/editProduct";

  final ProductBloc productBloc = ProductBloc();

  //Allows products to be dismissable horizontally
  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  void insertProductFromOlderVersion() async =>
      await BasicProductDAO().getProductsFromOlderVersion();

  @override
  void initState() {
    super.initState();
    insertProductFromOlderVersion();
    // _populateProducts();
  }

  // void _populateProducts() async {
  //   var products = await ProductModel().getAll();
  //   await SharedPrefs().setDBChange(false);

  //   setState(() {
  //     log("Atualizando...");
  //     _list = products;
  //     _list.length == 0 ? loadingText = "Sem produtos no momento." : "";
  //   });
  // }

  Widget bottomNavigationBar() {
    return BottomAppBar(
      color: MyColors().buttonColor(),
      child: Container(
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          ],
        ),
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
          child: Text("Produtos simples"),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                                Messages().showAlertDialog(context, "Produto Simples",
                    "Crie o preço de venda e custo de seus produtos/serviços de forma mais simples e rápida que o modo completo.\nEx.:\n" + 
                    "\nNome: Coxinha\n"+
                    "Custo: R\$ 0,50\n"+
                    "Lucro: 45 %\n"+
                    "Custo indireto: 0 %\n"+
                    "Comissão: 0 \n" + 
                    "Imposto 1: 10 %\n" + 
                    "Imposto 2: 0 %\n" + 
                    "Encargo: 0 %\n" + 
                    "Outros: 0 %\n" + 
                    "Custo Indireto: 3 %",
                    buttonText: "Entendi");
              }),
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                productBloc.getAll();
              }),
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
          child: Container(
            child: getProductsWidget(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        backgroundColor: MyColors().buttonColor(),
        onPressed: () {
          ScreenNavigator().newProductScreen(context, productBloc);
        },
        child: new Icon(Icons.add),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget buildProductList(BuildContext context, int index, List<dynamic> list) {
    Product product = list[index];

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
                        child: (list[index].uriImg != null)
                            ? Image.file(
                                new File(list[index].uriImg),
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
                            "Preço dentro: R\$ ${product.precoDentro.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Preço fora: R\$ ${product.precoFora.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
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

  Widget getProductsWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (products)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: productBloc.products,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        return getProductWidget(snapshot);
      },
    );
  }

  Widget getProductWidget(AsyncSnapshot<List<Product>> snapshot) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of product from DB.
      If that the case show user that you have empty products
      */
      return snapshot.data.length != 0
          ? new ListView.builder(
              itemCount: snapshot.data.length,
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
                        "Deseja excluir o item ${snapshot.data[index].nome}?",
                        null, () async {
                      // Sim
                      productBloc.deleteById(snapshot.data[index].id);
                      Navigator.of(context).pop();
                    }, () {
                      // Não
                      Navigator.of(context).pop();
                    });
                  },
                  direction: _dismissDirection,
                  key: UniqueKey(),
                  child: GestureDetector(
                    child: buildProductList(context, index, snapshot.data),
                    onTap: () {
                      ScreenNavigator().updateProduct(context, snapshot.data[index], productBloc);
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
    productBloc.getAll();
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
        "Adicione um produto...",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}
