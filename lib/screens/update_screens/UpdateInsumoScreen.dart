import 'dart:developer';

import 'package:calcular_preco_venda/Router.dart';
import 'package:calcular_preco_venda/bloc/InsumoBloc.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Conversion.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/utils/SharedPrefs.dart';
import 'package:calcular_preco_venda/widgets/AdmobWidget.dart';
import 'package:flutter/material.dart';
import 'package:calcular_preco_venda/objects/Insumo.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UpdateInsumoScreen extends StatefulWidget {
  final Insumo insumo;
  final InsumoBloc insumoBloc;

  UpdateInsumoScreen(this.insumo, this.insumoBloc);
  @override
  _UpdateInsumoScreenState createState() => _UpdateInsumoScreenState();
}

class _UpdateInsumoScreenState extends State<UpdateInsumoScreen> {
  final TextEditingController nameController = new TextEditingController();
  // final TextEditingController idUnidadeController = new TextEditingController();
  final TextEditingController valorUnitController = new TextEditingController();

  final Messages message = new Messages();
  bool _isInAsyncCall = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);
  Insumo _updatedInsumo = Insumo();
  Conversion _conversion = new Conversion();

  static var riKeys9 = GlobalKey<FormState>();

  @override
  void initState() {
    loadInsumo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// Widgets para os campos

    final nameField = TextFormField(
      controller: nameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Preencha o nome do insumo';
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

    // final idUnidField = TextFormField(
    //   controller: idUnidadeController,
    //   keyboardType: TextInputType.number,
    //   style: style,
    //   decoration: InputDecoration(
    //     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //     hintText: "Unidade do insumo",
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(32.0),
    //     ),
    //   ),
    // );

    // Valor unitário
    final valorUnitField = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Preencha o valor unitário';
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

    final newInsumoButton = SimpleRoundButtonGrad(
      colors: [MyColors().appBarColor(), MyColors().buttonColor()],
      textColor: Colors.white,
      splashColor: Colors.white,
      buttonText: "Atualizar",
      onPressed: () {
        if (!riKeys9.currentState!.validate()) {
        } else {
          updateInsumo();
        }
      },
    );

    final form = (Form(
      key: riKeys9,
      child: Column(
        children: <Widget>[
          nameField,
          // SizedBox(height: 15.0),
          // idUnidField,
          SizedBox(height: 15.0),
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
          title: new Text("Atualização insumo"),
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
                            child: newInsumoButton,
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

  void createInsumo() {
    _updatedInsumo = new Insumo(
        id: widget.insumo.id,
        nome: nameController.text,
        // idUnid: idUnidadeController.text.isNotEmpty
        //     ? int.parse(idUnidadeController.text)
        //     : null,
        valorUnitario: _conversion.replaceCommaToDot(valorUnitController.text));
  }

  void updateInsumo() async {
    createInsumo();

    setState(() {
      _isInAsyncCall = true;
    });
    try {
      print(_updatedInsumo.toMap());
      var isUpdated = await widget.insumoBloc.updateInsumo(_updatedInsumo);

      if (isUpdated != null) {
        setState(() {
          _isInAsyncCall = false;
          Messages().showOkDialog(context, 'Insumo atualizado',
              'Insumo ${nameController.text} atualizado com sucesso !', () {
            Navigator.of(context).pop();
            Navigator.pop(context);
          });
        });
      } else {
        setState(() {
          _isInAsyncCall = false;
        });
        Messages().showAlertDialog(
            context, 'Erro', 'Ocorreu um erro ao tentar atualizar o insumo.');
      }
    } catch (e) {
      setState(() {
        _isInAsyncCall = false;
      });
      Messages().showAlertDialog(context, 'Erro',
          'Ocorreu um erro ao tentar atualizar o insumo.\nErro: $e');
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

  loadInsumo() {
    if (widget.insumo != null) {
      nameController.text = widget.insumo.nome.toString();
      // idUnidadeController.text = widget.insumo.idUnid.toString();
      valorUnitController.text = widget.insumo.valorUnitario.toString();
    }
  }
}
