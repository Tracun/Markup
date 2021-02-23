import 'dart:developer';

import 'package:calcular_preco_venda/bloc/TempoFabBloc.dart';
import 'package:calcular_preco_venda/objects/TempoFab.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Conversion.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TempoFabListWidget extends StatefulWidget {
  final List<TempoFabList> selectedTempoFabList;
  TempoFabListWidget({Key key, @required this.selectedTempoFabList})
      : super(key: key);

  @override
  _TempoFabListWidgetState createState() => _TempoFabListWidgetState();
}

class _TempoFabListWidgetState extends State<TempoFabListWidget> {
  final quantHorasController = new TextEditingController();
  List<TempoFab> _tempoFabList = new List<TempoFab>();

  int selectedItem = 0;
  String tempoFabName = "Selecione ...";
  DatePickerTheme theme = new DatePickerTheme();
  TempoFabBloc _tempoFabBloc = TempoFabBloc();
  static var riKeys12 = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  Widget quantField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Preencha a quantidade';
        }
        return null;
      },
      controller: quantHorasController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Horas",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  Future<void> _populateTempoFabs() async {
    Stream stream = _tempoFabBloc.tempoFabs;

    _tempoFabList = await stream.first;
  }

  List<DropdownMenuItem<dynamic>> getDropDownMenuItems() {
    List<DropdownMenuItem<dynamic>> items = new List();

    _tempoFabList.isNotEmpty
        ? _tempoFabList
            .map((tempoFab) => items.add(
                DropdownMenuItem(value: tempoFab, child: new Text(tempoFab.descricao))))
            .toList()
        : null;
    return items;
  }

  Widget _renderTempoFabTitleActionsView() {
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
                  tempoFabName = _tempoFabList[selectedItem].descricao;
                  quantHorasController.selection;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderTempoFabItemView() {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 36.0,
        looping: false,
        backgroundColor: CupertinoColors.white,
        // useMagnifier: true,
        onSelectedItemChanged: (int index) {
          selectedItem = index;
        },
        children: List<Widget>.generate(_tempoFabList.length, (index) {
          return Center(
            child: Text(_tempoFabList[index].descricao,
                style: TextStyle(color: Colors.black, fontSize: 14)),
          );
        }),
      ),
    );
  }

  // Return Title and itemList
  Widget _renderTempoFabPickerView() {
    Widget itemView = _renderTempoFabItemView();

    return Container(
      height: 350.0,
      child: Column(
        children: <Widget>[
          _renderTempoFabTitleActionsView(),
          itemView,
        ],
      ),
    );
  }

  @override
  void initState() {
    _populateTempoFabs();
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
                        "TEMPO FAB",
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
                                    return _renderTempoFabPickerView();
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
                    "$tempoFabName",
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: quantField(),
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
                if (riKeys12.currentState.validate()) {
                  setState(() {
                    if (selectedItem != null) {
                      widget.selectedTempoFabList.add(
                        new TempoFabList(
                          _tempoFabList[selectedItem].id,
                          Conversion().replaceCommaToDot(quantHorasController.text),
                        ),
                      );
                      quantHorasController.clear();
                      quantHorasController.selection;
                      tempoFabName = "Selecione ...";
                      selectedItem = 0;
                    } else {
                      Messages().showAlertDialog(context,
                          "TempoFab não selecionado", "Selecione um tempoFab");
                    }
                  });
                }
              },
            ),
          ),
          new ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.selectedTempoFabList != null
                ? widget.selectedTempoFabList.length
                : 0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: widget.selectedTempoFabList.isEmpty
                    ? Center(child: Text('Sem tempoFabs'))
                    : buildTempoFabList(
                        context, index, widget.selectedTempoFabList),
                onTap: () {
                  if (widget.selectedTempoFabList.isNotEmpty) {
                    Messages().showYesNoDialog(
                        context,
                        "Exclusão",
                        "Deseja excluir o tempoFab ${widget.selectedTempoFabList[index].id}?",
                        null, () {
                      // Sim
                      Navigator.of(context).pop();
                      setState(() {
                        widget.selectedTempoFabList.removeAt(index);
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

  Widget buildTempoFabList(
      BuildContext context, int index, List<TempoFabList> list) {
    return 
    Padding(
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
                            "ID: ${list[index].id} - Quant: ${list[index].quant}",
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
