import 'dart:developer';

import 'package:calcular_preco_venda/bloc/DespesaAdmBloc.dart';
import 'package:calcular_preco_venda/objects/DespesaAdm.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Conversion.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DespesaAdmListWidget extends StatefulWidget {
  final List<DespesaAdmList>? selectedDespesaAdmList;
  DespesaAdmListWidget({Key? key, @required this.selectedDespesaAdmList})
      : super(key: key);

  @override
  _DespesaAdmListWidgetState createState() => _DespesaAdmListWidgetState();
}

class _DespesaAdmListWidgetState extends State<DespesaAdmListWidget> {
  final quantController = new TextEditingController();
  List<DespesaAdm> _despesaAdmList = <DespesaAdm>[];

  int selectedItem = 0;
  String despesaAdmName = "Selecione ...";
  DatePickerTheme theme = new DatePickerTheme();
  DespesaAdmBloc _despesaAdmBloc = DespesaAdmBloc();
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
        hintText: "Horas",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  Future<void> _populateDespesaAdms() async {
    Stream stream = _despesaAdmBloc.despesaAdms;

    _despesaAdmList = await stream.first;
  }

  List<DropdownMenuItem<dynamic>> getDropDownMenuItems() {
    List<DropdownMenuItem<dynamic>> items = [];

    _despesaAdmList.isNotEmpty
        ? _despesaAdmList
            .map((despesaAdm) => items.add(DropdownMenuItem(
                value: despesaAdm, child: new Text(despesaAdm.descricao!))))
            .toList()
        : null;
    return items;
  }

  Widget _renderDespesaAdmTitleActionsView() {
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
                  despesaAdmName = _despesaAdmList[selectedItem].descricao!;
                  quantController.selection;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderDespesaAdmItemView() {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 36.0,
        looping: false,
        backgroundColor: CupertinoColors.white,
        // useMagnifier: true,
        onSelectedItemChanged: (int index) {
          selectedItem = index;
        },
        children: List<Widget>.generate(_despesaAdmList.length, (index) {
          return Center(
            child: Text("${_despesaAdmList[index].descricao!} - R\$ ${_despesaAdmList[index].valor}/hora",
                style: TextStyle(color: Colors.black, fontSize: 14)),
          );
        }),
      ),
    );
  }

  // Return Title and itemList
  Widget _renderDespesaAdmPickerView() {
    Widget itemView = _renderDespesaAdmItemView();

    return Container(
      height: 350.0,
      child: Column(
        children: <Widget>[
          _renderDespesaAdmTitleActionsView(),
          itemView,
        ],
      ),
    );
  }

  @override
  void initState() {
    _populateDespesaAdms();
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
                        "Despesas Adm",
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
                                    return _renderDespesaAdmPickerView();
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
                    "$despesaAdmName",
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
                    if (selectedItem != null) {
                      widget.selectedDespesaAdmList!.add(
                        new DespesaAdmList(
                          _despesaAdmList[selectedItem].id!,
                          Conversion().replaceCommaToDot(quantController.text),
                          _despesaAdmList[selectedItem].descricao!,
                        ),
                      );
                      quantController.clear();
                      quantController.selection;
                      despesaAdmName = "Selecione ...";
                      selectedItem = 0;
                    } else {
                      Messages().showAlertDialog(
                          context,
                          "Despesa Adm não selecionado",
                          "Selecione um despesa Adm");
                    }
                  });
                }
              },
            ),
          ),
          new ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.selectedDespesaAdmList != null
                ? widget.selectedDespesaAdmList!.length
                : 0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: widget.selectedDespesaAdmList!.isEmpty
                    ? Center(child: Text('Sem despesas Adm'))
                    : buildDespesaAdmList(
                        context, index, widget.selectedDespesaAdmList!),
                onTap: () {
                  if (widget.selectedDespesaAdmList!.isNotEmpty) {
                    Messages().showYesNoDialog(
                        context,
                        "Exclusão",
                        "Deseja excluir a despesaAdm ${widget.selectedDespesaAdmList![index].descricao == null ? widget.selectedDespesaAdmList![index].id : widget.selectedDespesaAdmList![index].descricao}?",
                        null, () {
                      // Sim
                      Navigator.of(context).pop();
                      setState(() {
                        widget.selectedDespesaAdmList!.removeAt(index);
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

  Widget buildDespesaAdmList(
      BuildContext context, int index, List<DespesaAdmList> list) {
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
                            "ID: ${list[index].descricao == null ? list[index].id : list[index].descricao} - Quant: ${list[index].quant}",
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
