import 'dart:developer';

import 'package:calcular_preco_venda/bloc/ImpostoBloc.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Conversion.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/widgets/AdmobWidget.dart';
import 'package:flutter/material.dart';
import 'package:calcular_preco_venda/objects/Imposto.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UpdateImpostoScreen extends StatefulWidget {
  final Imposto imposto;
  final ImpostoBloc impostoBloc;

  UpdateImpostoScreen(this.imposto, this.impostoBloc);
  @override
  _UpdateImpostoScreenState createState() => _UpdateImpostoScreenState();
}

class _UpdateImpostoScreenState extends State<UpdateImpostoScreen> {
  final TextEditingController descricaoController = new TextEditingController();
  final TextEditingController porcentagemController =
      new TextEditingController();

  final Messages message = new Messages();
  bool _isInAsyncCall = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);
  Imposto _updatedImposto = Imposto();
  Conversion _conversion = new Conversion();

  static var riKeys8 = GlobalKey<FormState>();

  @override
  void initState() {
    loadImposto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// Widgets para os campos

    final descricaoField = TextFormField(
      controller: descricaoController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Descrição imposto';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Descrição",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    // Valor unitário
    final porcentagemField = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Porcentagem imposto';
        }
        return null;
      },
      controller: porcentagemController,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "% imposto",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final updateImpostoButton = SimpleRoundButtonGrad(
      colors: [MyColors().appBarColor(), MyColors().buttonColor()],
      textColor: Colors.white,
      splashColor: Colors.white,
      buttonText: "Atualizar",
      onPressed: () {
        if (!riKeys8.currentState!.validate()) {
        } else {
          updateImposto();
        }
      },
    );

    final form = (Form(
      key: riKeys8,
      child: Column(
        children: <Widget>[
          descricaoField,
          SizedBox(height: 15.0),
          porcentagemField,
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
          title: new Text("Atualização imposto"),
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
                            child: updateImpostoButton,
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

  void createImposto() {
    _updatedImposto = new Imposto(
        id: widget.imposto.id,
        descricao: descricaoController.text,
        porcentagem: _conversion.replaceCommaToDot(porcentagemController.text));
  }

  void updateImposto() async {
    createImposto();

    setState(() {
      _isInAsyncCall = true;
    });
    try {
      var isUpdated = await widget.impostoBloc.updateImposto(_updatedImposto);
      if (isUpdated != null) {
        setState(() {
          _isInAsyncCall = false;
          Messages().showOkDialog(context, 'Imposto atualizado',
              'Imposto ${descricaoController.text} atualizado com sucesso !',
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
            context, 'Erro', 'Ocorreu um erro ao tentar atualizar o imposto.');
      }
    } catch (e) {
      setState(() {
        _isInAsyncCall = false;
      });
      Messages().showAlertDialog(context, 'Erro',
          'Ocorreu um erro ao tentar atualizar o imposto.\nErro: $e');
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

  loadImposto() {
    if (widget.imposto != null) {
      descricaoController.text = widget.imposto.descricao.toString();
      porcentagemController.text = widget.imposto.porcentagem.toString();
    }
  }
}
