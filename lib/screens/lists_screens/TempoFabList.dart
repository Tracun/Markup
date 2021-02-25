import 'dart:developer';
import 'dart:io';
import 'package:calcular_preco_venda/bloc/TempoFabBloc.dart';
import 'package:calcular_preco_venda/objects/TempoFab.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/utils/ScreenNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TempoFabListScreen extends StatefulWidget {
  createState() => _TempoFabListAdmState();
}

class _TempoFabListAdmState extends State<TempoFabListScreen> {
  String loadingText;

  final TempoFabBloc _tempoFabBloc = TempoFabBloc();

  //Allows tempoFabs to be dismissable horizontally
  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  @override
  void initState() {
    super.initState();
  }

  Widget bottomNavigationBar() {
    return BottomAppBar(
      color: MyColors().buttonColor(),
      child: Container(
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[],
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
          child: Text("Tempo Fabricação"),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                Messages().showAlertDialog(context, "Tempo de fabricação",
                    "Tempo utilizado para fabricação ou aplicação de um serviço e/ou produto.\nEx.:\nNome: Fritar Coxinha\nValor hora: R\$ 0,35/hora",
                    buttonText: "Entendi");
              }),
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                _tempoFabBloc.getAll();
              }),
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
          child: Container(
            child: getTempoFabsWidget(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        backgroundColor: MyColors().buttonColor(),
        onPressed: () {
          ScreenNavigator().newTempoFabScreen(context, _tempoFabBloc);
        },
        child: new Icon(Icons.add),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget buildTempoFabList(
      BuildContext context, int index, List<dynamic> list) {
    TempoFab tempoFab = list[index];

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
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Color.fromRGBO(37, 143, 98, 1),
                    child: ClipOval(
                      child: new SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset(
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
                            tempoFab.descricao,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          )),
                        ),
                        // Prices
                        Container(
                          child: Text(
                            "R\$ ${tempoFab.valorHora}",
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

  Widget getTempoFabsWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (tempoFabs)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: _tempoFabBloc.tempoFabs,
      builder: (BuildContext context, AsyncSnapshot<List<TempoFab>> snapshot) {
        return getTempoFabWidget(snapshot);
      },
    );
  }

  Widget getTempoFabWidget(AsyncSnapshot<List<TempoFab>> snapshot) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of tempoFab from DB.
      If that the case show user that you have empty tempoFabs
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
                        "Deseja excluir o item ${snapshot.data[index].descricao}?",
                        null, () async {
                      // Sim
                      _tempoFabBloc.deleteById(snapshot.data[index].id);
                      Navigator.of(context).pop();
                    }, () {
                      // Não
                      _tempoFabBloc.getAll();
                      Navigator.of(context).pop();
                    });
                  },
                  direction: _dismissDirection,
                  key: UniqueKey(),
                  child: GestureDetector(
                    child: buildTempoFabList(context, index, snapshot.data),
                    onTap: () {
                      ScreenNavigator().updateTempoFab(
                          context, snapshot.data[index], _tempoFabBloc);
                    },
                  ),
                );
              })
          : Container(
              child: Center(
              //this is used whenever there 0 tempoFabs
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
    //pull tempoFabs again
    _tempoFabBloc.getAll();
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
        "Adicione um tempoFab ...",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}
