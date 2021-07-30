import 'dart:developer';

import 'package:calcular_preco_venda/bloc/RateioBloc.dart';
import 'package:calcular_preco_venda/objects/Rateio.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Conversion.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RateioListWidget extends StatefulWidget {
  final List<RateioList> selectedRateioList;
  RateioListWidget({Key key, @required this.selectedRateioList})
      : super(key: key);

  @override
  _RateioListWidgetState createState() => _RateioListWidgetState();
}

class _RateioListWidgetState extends State<RateioListWidget> {
  final porcentagemController = new TextEditingController();
  List<Rateio> _rateioList = new List<Rateio>();

  int selectedItem = 0;
  String rateioName = "Selecione ...";
  DatePickerTheme theme = new DatePickerTheme();
  RateioBloc _rateioBloc = RateioBloc();
  static var riKeys12 = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  Widget porcentagemField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Preencha a porcentagem';
        }
        return null;
      },
      controller: porcentagemController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "%",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  Future<void> _populateRateios() async {
    Stream stream = _rateioBloc.rateios;

    _rateioList = await stream.first;
  }

  List<DropdownMenuItem<dynamic>> getDropDownMenuItems() {
    List<DropdownMenuItem<dynamic>> items = new List();

    _rateioList.isNotEmpty
        ? _rateioList
            .map((rateio) => items.add(
                DropdownMenuItem(value: rateio, child: new Text(rateio.descricao))))
            .toList()
        : null;
    return items;
  }

  Widget _renderRateioTitleActionsView() {
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
                  rateioName = _rateioList[selectedItem].descricao;
                  porcentagemController.selection;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderRateioItemView() {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 36.0,
        looping: false,
        backgroundColor: CupertinoColors.white,
        // useMagnifier: true,
        onSelectedItemChanged: (int index) {
          selectedItem = index;
        },
        children: List<Widget>.generate(_rateioList.length, (index) {
          return Center(
            child: Text(_rateioList[index].descricao,
                style: TextStyle(color: Colors.black, fontSize: 14)),
          );
        }),
      ),
    );
  }

  // Return Title and itemList
  Widget _renderRateioPickerView() {
    Widget itemView = _renderRateioItemView();

    return Container(
      height: 350.0,
      child: Column(
        children: <Widget>[
          _renderRateioTitleActionsView(),
          itemView,
        ],
      ),
    );
  }

  @override
  void initState() {
    _populateRateios();
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
                        "RATEIO",
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
                                    return _renderRateioPickerView();
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
                    "$rateioName",
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
                  child: porcentagemField(),
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
                      widget.selectedRateioList.add(
                        new RateioList(
                          _rateioList[selectedItem].id,
                          Conversion().replaceCommaToDot(porcentagemController.text),
                          _rateioList[selectedItem].descricao,
                        ),
                      );
                      porcentagemController.clear();
                      porcentagemController.selection;
                      rateioName = "Selecione ...";
                      selectedItem = 0;
                    } else {
                      Messages().showAlertDialog(context,
                          "Rateio não selecionado", "Selecione um rateio");
                    }
                  });
                }
              },
            ),
          ),
          new ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.selectedRateioList != null
                ? widget.selectedRateioList.length
                : 0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: widget.selectedRateioList.isEmpty
                    ? Center(child: Text('Sem rateios'))
                    : buildRateioList(
                        context, index, widget.selectedRateioList),
                onTap: () {
                  if (widget.selectedRateioList.isNotEmpty) {
                    Messages().showYesNoDialog(
                        context,
                        "Exclusão",
                        "Deseja excluir o rateio ${widget.selectedRateioList[index].descricao == null ? widget.selectedRateioList[index].id : widget.selectedRateioList[index].descricao}?",
                        null, () {
                      // Sim
                      Navigator.of(context).pop();
                      setState(() {
                        widget.selectedRateioList.removeAt(index);
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

  Widget buildRateioList(
      BuildContext context, int index, List<RateioList> list) {
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
                            "ID: ${list[index].descricao == null ? list[index].id : list[index].descricao} - Quant: ${list[index].porcentagemRateio}",
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
