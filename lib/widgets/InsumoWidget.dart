import 'dart:developer';

import 'package:calcular_preco_venda/bloc/InsumoBloc.dart';
import 'package:calcular_preco_venda/objects/Insumo.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Conversion.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class InsumoListWidget extends StatefulWidget {
  final List<InsumoList>? selectedInsumoList;
  InsumoListWidget({Key? key, @required this.selectedInsumoList})
      : super(key: key);

  @override
  _InsumoListWidgetState createState() => _InsumoListWidgetState();
}

class _InsumoListWidgetState extends State<InsumoListWidget> {
  final quantController = new TextEditingController();
  List<Insumo> _insumoList = <Insumo>[];

  int selectedItem = 0;
  String insumoName = "Selecione ...";
  DatePickerTheme theme = new DatePickerTheme();
  InsumoBloc _insumoBloc = InsumoBloc();
  static var riKeys12 = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  Widget quantField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Preencha a quantidade';
        }
        return null;
      },
      controller: quantController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Quant",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  Future<void> _populateInsumos() async {
    Stream stream = _insumoBloc.insumos;

    _insumoList = await stream.first;
  }

  List<DropdownMenuItem<dynamic>> getDropDownMenuItems() {
    List<DropdownMenuItem<dynamic>> items = [];

    _insumoList.isNotEmpty
        ? _insumoList
            .map((insumo) => items.add(
                DropdownMenuItem(value: insumo, child: new Text(insumo.nome!))))
            .toList()
        : null;
    return items;
  }

  Widget _renderInsumoTitleActionsView() {
    String done = "Selecionar";
    String cancel = "Cancelar";

    return Container(
      height: theme.titleHeight,
      decoration: BoxDecoration(color: theme.backgroundColor),
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
                  insumoName = _insumoList[selectedItem].nome!;
                  quantController.selection;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderInsumoItemView() {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 36.0,
        looping: false,
        backgroundColor: CupertinoColors.white,
        // useMagnifier: true,
        onSelectedItemChanged: (int index) {
          selectedItem = index;
        },
        children: List<Widget>.generate(_insumoList.length, (index) {
          return Center(
            child: Text("${_insumoList[index].nome!} - R\$ ${_insumoList[index].valorUnitario}",
                style: TextStyle(color: Colors.black, fontSize: 14)),
          );
        }),
      ),
    );
  }

  // Return Title and itemList
  Widget _renderInsumoPickerView() {
    Widget itemView = _renderInsumoItemView();

    return Container(
      height: 350.0,
      child: Column(
        children: <Widget>[
          _renderInsumoTitleActionsView(),
          itemView,
        ],
      ),
    );
  }

  @override
  void initState() {
    _populateInsumos();
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
                        "INSUMOS",
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
                                    return _renderInsumoPickerView();
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
                    "$insumoName",
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
                if (riKeys12.currentState!.validate()) {
                  setState(() {
                    if (quantController.text.toString().contains(",")) {
                      quantController.text.toString().replaceAll(",", ".");
                    }
                    if (selectedItem != null) {
                      widget.selectedInsumoList!.add(
                        new InsumoList(
                          _insumoList[selectedItem].id!,
                          Conversion().replaceCommaToDot(quantController.text),
                          _insumoList[selectedItem].nome!,
                        ),
                      );
                      quantController.clear();
                      quantController.selection;
                      insumoName = "Selecione ...";
                      selectedItem = 0;
                    } else {
                      Messages().showAlertDialog(context,
                          "Insumo não selecionado", "Selecione um insumo");
                    }
                  });
                }
              },
            ),
          ),
          new ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.selectedInsumoList != null
                ? widget.selectedInsumoList!.length
                : 0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: widget.selectedInsumoList!.isEmpty
                    ? Center(child: Text('Sem insumos'))
                    : buildInsumoList(
                        context, index, widget.selectedInsumoList!),
                onTap: () {
                  if (widget.selectedInsumoList!.isNotEmpty) {
                    Messages().showYesNoDialog(
                        context,
                        "Exclusão",
                        "Deseja excluir o insumo ${widget.selectedInsumoList![index].name == null ? widget.selectedInsumoList![index].id : widget.selectedInsumoList![index].name}?",
                        null, () {
                      // Sim
                      Navigator.of(context).pop();
                      setState(() {
                        widget.selectedInsumoList!.removeAt(index);
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

  Widget buildInsumoList(
      BuildContext context, int index, List<InsumoList> list) {
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
                            "ID: ${list[index].name == null ? list[index].id : list[index].name} - Quant: ${list[index].quant}",
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
