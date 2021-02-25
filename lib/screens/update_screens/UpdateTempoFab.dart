import 'package:calcular_preco_venda/bloc/TempoFabBloc.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Conversion.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/widgets/AdmobWidget.dart';
import 'package:flutter/material.dart';
import 'package:calcular_preco_venda/objects/TempoFab.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UpdateTempoFabScreen extends StatefulWidget {
  final TempoFab tempoFab;
  final TempoFabBloc tempoFabBloc;

  UpdateTempoFabScreen(this.tempoFab, this.tempoFabBloc);
  @override
  _UpdateTempoFabScreenState createState() => _UpdateTempoFabScreenState();
}

class _UpdateTempoFabScreenState extends State<UpdateTempoFabScreen> {
  final TextEditingController descricaoController = new TextEditingController();
  final TextEditingController valorHoraController = new TextEditingController();

  final Messages message = new Messages();
  bool _isInAsyncCall = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);
  TempoFab _updatedTempoFab;
  Conversion _conversion = new Conversion();

  static var riKeys11 = GlobalKey<FormState>();

  @override
  void initState() {
    loadTempoFab();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// Widgets para os campos

    final descricaoField = TextFormField(
      controller: descricaoController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Descrição tempoFab';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "TempoFab",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    // Valor hora
    final valorHoraField = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Preencha o valor hora';
        }
        return null;
      },
      controller: valorHoraController,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Valor hora",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final updateTempoFabButton = SimpleRoundButtonGrad(
      colors: [MyColors().appBarColor(), MyColors().buttonColor()],
      textColor: Colors.white,
      splashColor: Colors.white,
      buttonText: "Atualizar",
      onPressed: () {
        if (!riKeys11.currentState.validate()) {
        } else {
          updateTempoFab();
        }
      },
    );

    final form = (Form(
      key: riKeys11,
      child: Column(
        children: <Widget>[
          descricaoField,
          SizedBox(height: 15.0),
          valorHoraField,
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
          title: new Text("Atualização tempo Fabricação"),
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
                            child: updateTempoFabButton,
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

  void createTempoFab() {
    _updatedTempoFab = new TempoFab(
        id: widget.tempoFab.id,
        descricao: descricaoController.text,
        valorHora: _conversion.replaceCommaToDot(valorHoraController.text));
  }

  void updateTempoFab() async {
    createTempoFab();

    setState(() {
      _isInAsyncCall = true;
    });
    try {
      var isUpdated =
          await widget.tempoFabBloc.updateTempoFab(_updatedTempoFab);
      if (isUpdated != null) {
        setState(() {
          _isInAsyncCall = false;
          Messages().showOkDialog(context, 'TempoFab atualizado',
              'TempoFab ${descricaoController.text} atualizado com sucesso !',
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
            context, 'Erro', 'Ocorreu um erro ao tentar atualizar o tempoFab.');
      }
    } catch (e) {
      setState(() {
        _isInAsyncCall = false;
      });
      Messages().showAlertDialog(context, 'Erro',
          'Ocorreu um erro ao tentar atualizar o tempoFab.\nErro: $e');
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

  loadTempoFab() {
    if (widget.tempoFab != null) {
      descricaoController.text = widget.tempoFab.descricao.toString();
      valorHoraController.text = widget.tempoFab.valorHora.toString();
    }
  }
}
