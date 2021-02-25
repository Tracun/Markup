import 'dart:developer';
import 'dart:io';
import 'package:calcular_preco_venda/bloc/DespesaAdmBloc.dart';
import 'package:calcular_preco_venda/objects/DespesaAdm.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/utils/ScreenNavigator.dart';
import 'package:calcular_preco_venda/widgets/AdmobWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DespesaAdmListScreen extends StatefulWidget {
  createState() => _DespesaAdmListAdmState();
}

class _DespesaAdmListAdmState extends State<DespesaAdmListScreen> {
  String loadingText;

  final DespesaAdmBloc _despesaAdmBloc = DespesaAdmBloc();

  //Allows despesaAdms to be dismissable horizontally
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
          children: <Widget>[
            // AdmobWidget().getBottomBanner(),
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
          child: Text("DespesaAdms"),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                Messages().showAlertDialog(context, "Despesas",
                    "Despesa, para a Contabilidade, é o gasto necessário para a obtenção de receita. As Despesas são gastos que não se identificam com o processo de transformação ou produção dos bens e produtos. As despesas estão relacionadas aos valores gastos com a estrutura administrativa e comercial da empresa. Ex: aluguel, salários e encargos, pró-labore, telefone, propaganda, impostos, comissões de vendedores etc. Elas ainda são classificadas em fixas e variáveis, sendo as fixas aquelas cujo valor a ser pago não depende do volume, ou do valor das vendas, enquanto que as variáveis são aquelas cujo valor a ser pago está diretamente relacionado ao valor vendido.\nEx.:\nNome: Salário hora\nValor: R\$ 35,00",
                    buttonText: "Entendi");
              }),
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                _despesaAdmBloc.getAll();
              }),
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
          child: Container(
            child: getDespesaAdmsWidget(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        backgroundColor: MyColors().buttonColor(),
        onPressed: () {
          ScreenNavigator().newDespesaAdmScreen(context, _despesaAdmBloc);
        },
        child: new Icon(Icons.add),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget buildDespesaAdmList(
      BuildContext context, int index, List<dynamic> list) {
    DespesaAdm despesaAdm = list[index];

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
                            despesaAdm.descricao,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          )),
                        ),
                        // Prices
                        Container(
                          child: Text(
                            "R\$ ${despesaAdm.valor}",
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

  Widget getDespesaAdmsWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (despesaAdms)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: _despesaAdmBloc.despesaAdms,
      builder:
          (BuildContext context, AsyncSnapshot<List<DespesaAdm>> snapshot) {
        return getDespesaAdmWidget(snapshot);
      },
    );
  }

  Widget getDespesaAdmWidget(AsyncSnapshot<List<DespesaAdm>> snapshot) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of despesaAdm from DB.
      If that the case show user that you have empty despesaAdms
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
                      _despesaAdmBloc.deleteById(snapshot.data[index].id);
                      Navigator.of(context).pop();
                    }, () {
                      // Não
                      _despesaAdmBloc.getAll();
                      Navigator.of(context).pop();
                    });
                  },
                  direction: _dismissDirection,
                  key: UniqueKey(),
                  child: GestureDetector(
                    child: buildDespesaAdmList(context, index, snapshot.data),
                    onTap: () {
                      ScreenNavigator().updateDespesaAdm(
                          context, snapshot.data[index], _despesaAdmBloc);
                    },
                  ),
                );
              })
          : Container(
              child: Center(
              //this is used whenever there 0 despesaAdms
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
    //pull despesaAdms again
    _despesaAdmBloc.getAll();
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
        "Adicione um despesaAdm ...",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}
