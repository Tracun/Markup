import 'dart:developer';

import 'package:calcular_preco_venda/bloc/ImpostoBloc.dart';
import 'package:calcular_preco_venda/objects/Imposto.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ImpostoListWidget extends StatefulWidget {
  final List<int> selectedImpostoList;
  ImpostoListWidget({Key key, @required this.selectedImpostoList})
      : super(key: key);

  @override
  _ImpostoListWidgetState createState() => _ImpostoListWidgetState();
}

class _ImpostoListWidgetState extends State<ImpostoListWidget> {
  List<Imposto> _impostoList = new List<Imposto>();

  int selectedItem = 0;
  String impostoName = "Selecione ...";
  DatePickerTheme theme = new DatePickerTheme();
  ImpostoBloc _impostoBloc = ImpostoBloc();
  static var riKeys12 = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  Future<void> _populateImpostos() async {
    Stream stream = _impostoBloc.impostos;

    _impostoList = await stream.first;
  }

  List<DropdownMenuItem<dynamic>> getDropDownMenuItems() {
    List<DropdownMenuItem<dynamic>> items = new List();

    _impostoList.isNotEmpty
        ? _impostoList
            .map((imposto) => items.add(DropdownMenuItem(
                value: imposto, child: new Text(imposto.descricao))))
            .toList()
        : null;
    return items;
  }

  Widget _renderImpostoTitleActionsView() {
    String done = "Selecionar";
    String cancel = "Cancelar";

    return Container(
      height: theme.titleHeight,
      decoration: BoxDecoration(color: theme.backgroundColor ?? Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: theme.titleHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: EdgeInsets.only(left: 16, top: 0),
              child: Text(
                "$cancel",
                style: theme.cancelStyle,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            height: theme.titleHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: EdgeInsets.only(right: 16, top: 0),
              child: Text(
                "$done",
                style: theme.doneStyle,
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  impostoName = _impostoList[selectedItem].descricao;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderImpostoItemView() {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 36.0,
        looping: false,
        backgroundColor: CupertinoColors.white,
        // useMagnifier: true,
        onSelectedItemChanged: (int index) {
          selectedItem = index;
        },
        children: List<Widget>.generate(_impostoList.length, (index) {
          return Center(
            child: Text(_impostoList[index].descricao,
                style:
                    TextStyle(color: Colors.black, fontSize: 14)),
          );
        }),
      ),
    );
  }

  // Return Title and itemList
  Widget _renderImpostoPickerView() {
    Widget itemView = _renderImpostoItemView();

    return Container(
      height: 350.0,
      child: Column(
        children: <Widget>[
          _renderImpostoTitleActionsView(),
          itemView,
        ],
      ),
    );
  }

  @override
  void initState() {
    _populateImpostos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   body:
        Form(
      key: riKeys12,
      child: Column(
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              children: <Widget>[
                // Expanded(
                //   child:
                new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
                // ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "IMPOSTO",
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: MyColors().buttonColor(),
                          child: MaterialButton(
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              showModalBottomSheet<int>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _renderImpostoPickerView();
                                  });
                            },
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        width: 80,
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   child:
                new Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Divider(
                    color: Colors.black,
                    height: 36,
                  ),
                ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "$impostoName",
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          SizedBox(
            child: SimpleRoundButtonGrad(
              colors: MyColors().buttonGradientColor(),
              textColor: Colors.white,
              splashColor: Colors.white,
              buttonText: "Adicionar",
              onPressed: () {
                // if (riKeys12.currentState.validate()) {
                  setState(() {
                    if (selectedItem != null) {
                      widget.selectedImpostoList.add(
                        _impostoList[selectedItem].id,
                      );
                      impostoName = "Selecione ...";
                      selectedItem = 0;
                    } else {
                      Messages().showAlertDialog(context,
                          "Imposto não selecionado", "Selecione um imposto");
                    }
                  });
                // }
              },
            ),
          ),
          new ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.selectedImpostoList != null
                ? widget.selectedImpostoList.length
                : 0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: widget.selectedImpostoList.isEmpty
                    ? Center(child: Text('Sem impostos'))
                    : buildImpostoList(
                        context, index, widget.selectedImpostoList),
                onTap: () {
                  if (widget.selectedImpostoList.isNotEmpty) {
                    Messages().showYesNoDialog(
                        context,
                        "Exclusão",
                        "Deseja excluir o imposto ${widget.selectedImpostoList[index]}?",
                        null, () {
                      // Sim
                      Navigator.of(context).pop();
                      setState(() {
                        widget.selectedImpostoList.removeAt(index);
                      });
                    }, () {
                      // Não
                      Navigator.of(context).pop();
                    });
                  }
                },
              );
            },
          ),
        ],
      ),
      // ),
    );
  }

  Widget buildImpostoList(
      BuildContext context, int index, List<int> list) {
    return Padding(
      padding: const EdgeInsets.only(left: 48, right: 48, top: 5, bottom: 5),
      child: Container(
        child: FittedBox(
          fit: BoxFit.cover,
          child: Material(
            color: Colors.white,
            elevation: 6.0,
            borderRadius: BorderRadius.circular(3.0),
            shadowColor: MyColors().appBarColor(),
            child: Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4.0, top: 0.5, bottom: 0.5),
                        child: Container(
                          child: Text(
                            "ID: ${list[index]}",
                            style: TextStyle(
                              fontSize: 2.0,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
