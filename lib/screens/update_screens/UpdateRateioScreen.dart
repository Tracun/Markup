import 'dart:developer';

import 'package:calcular_preco_venda/bloc/RateioBloc.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Conversion.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/utils/SharedPrefs.dart';
import 'package:calcular_preco_venda/widgets/AdmobWidget.dart';
import 'package:flutter/material.dart';
import 'package:calcular_preco_venda/objects/Rateio.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UpdateRateio extends StatefulWidget {
  final Rateio rateio;
  final RateioBloc rateioBloc;

  UpdateRateio(this.rateio, this.rateioBloc);
  @override
  _UpdateRateioState createState() => _UpdateRateioState();
}

class _UpdateRateioState extends State<UpdateRateio> {
  final TextEditingController descricaoController = new TextEditingController();
  final TextEditingController idUnidadeController = new TextEditingController();
  final TextEditingController valorUnitController = new TextEditingController();

  final Messages message = new Messages();
  bool _isInAsyncCall = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);
  Rateio _rateio;
  Conversion _conversion = new Conversion();

  static var riKeys10 = GlobalKey<FormState>();

  @override
  void initState() {
    loadRateio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// Widgets para os campos

    final descricaoField = TextFormField(
      controller: descricaoController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Descrição do rateio';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Nome",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final idUnidField = TextFormField(
      controller: idUnidadeController,
      keyboardType: TextInputType.number,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Unidade do rateio",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    // Valor unitário
    final valorUnitField = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Preencha o valor';
        }
        return null;
      },
      controller: valorUnitController,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "R\$ 0,00",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final newRateioButton = SimpleRoundButtonGrad(
      colors: [MyColors().appBarColor(), MyColors().buttonColor()],
      textColor: Colors.white,
      splashColor: Colors.white,
      buttonText: "Atualizar",
      onPressed: () {
        if (!riKeys10.currentState.validate()) {
        } else {
          updateRateio();
        }
      },
    );

    final form = (Form(
      key: riKeys10,
      child: Column(
        children: <Widget>[
          descricaoField,
          SizedBox(height: 15.0),
          // idUnidField,
          // SizedBox(height: 15.0),
          valorUnitField,
          SizedBox(height: 15.0),
        ],
      ),
    ));

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: MyColors().appBarColor(),
          automaticallyImplyLeading: true,
          title: new Text("Atualização rateio"),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isInAsyncCall,
          child: Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        form,
                        SizedBox(
                          height: 25.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: SizedBox(
                            child: newRateioButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          alignment: Alignment.bottomCenter,
          child: AdmobWidget().getBottomBanner(),
        ),
      ),
    );
  }

  void createRateio() {
    _rateio = new Rateio(
        id: widget.rateio.id,
        descricao: descricaoController.text,
        valor: _conversion.replaceCommaToDot(valorUnitController.text));
  }

  void updateRateio() async {
    createRateio();

    setState(() {
      _isInAsyncCall = true;
    });
    try {
      var isUpdated = await widget.rateioBloc.updateRateio(_rateio);
      if (isUpdated != null) {
        await SharedPrefs().setDBChange(true);
        setState(() {
          _isInAsyncCall = false;
          Messages().showOkDialog(context, 'Rateio atualizado',
              'Rateio ${descricaoController.text} atualizado com sucesso !',
              () {
            Navigator.of(context).pop();
            Navigator.pop(context);
          });
        });
      } else {
        setState(() {
          _isInAsyncCall = false;
        });
        Messages().showAlertDialog(
            context, 'Erro', 'Ocorreu um erro ao tentar atualizar o rateio.');
      }
    } catch (e) {
      setState(() {
        _isInAsyncCall = false;
      });
      Messages().showAlertDialog(context, 'Erro',
          'Ocorreu um erro ao tentar atualizar o rateio.\nErro: $e');
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Tem certeza?'),
            content: new Text(
                'Quer voltar a tela principal? Dados não salvos serão perdidos !'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Não'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Sim'),
              ),
            ],
          ),
        )) ??
        false;
  }

  loadRateio() {
    if (widget.rateio != null) {
      descricaoController.text = widget.rateio.descricao.toString();
      valorUnitController.text = widget.rateio.valor.toString();
    }
  }
}
