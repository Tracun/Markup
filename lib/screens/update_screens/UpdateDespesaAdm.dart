import 'package:calcular_preco_venda/bloc/DespesaAdmBloc.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Conversion.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/widgets/AdmobWidget.dart';
import 'package:flutter/material.dart';
import 'package:calcular_preco_venda/objects/DespesaAdm.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UpdateDespesaAdmScreen extends StatefulWidget {
  final DespesaAdm despesaAdm;
  final DespesaAdmBloc despesaAdmBloc;

  UpdateDespesaAdmScreen(this.despesaAdm, this.despesaAdmBloc);
  @override
  _UpdateDespesaAdmScreenState createState() => _UpdateDespesaAdmScreenState();
}

class _UpdateDespesaAdmScreenState extends State<UpdateDespesaAdmScreen> {
  final TextEditingController descricaoController = new TextEditingController();
  final TextEditingController valorController = new TextEditingController();

  final Messages message = new Messages();
  bool _isInAsyncCall = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);
  DespesaAdm _updatedDespesaAdm = DespesaAdm();
  Conversion _conversion = new Conversion();

  static var riKeys7 = GlobalKey<FormState>();

  @override
  void initState() {
    loadDespesaAdm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// Widgets para os campos

    final descricaoField = TextFormField(
      controller: descricaoController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Descrição despesaAdm';
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
    final valorField = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'valor despesa Adm';
        }
        return null;
      },
      controller: valorController,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Valor hora",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final updateDespesaAdmButton = SimpleRoundButtonGrad(
      colors: [MyColors().appBarColor(), MyColors().buttonColor()],
      textColor: Colors.white,
      splashColor: Colors.white,
      buttonText: "Atualizar",
      onPressed: () {
        if (!riKeys7.currentState!.validate()) {
        } else {
          updateDespesaAdm();
        }
      },
    );

    final form = (Form(
      key: riKeys7,
      child: Column(
        children: <Widget>[
          descricaoField,
          SizedBox(height: 15.0),
          valorField,
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
          title: new Text("Atualização despesa Adm"),
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
                            child: updateDespesaAdmButton,
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

  void createDespesaAdm() {
    _updatedDespesaAdm = new DespesaAdm(
        id: widget.despesaAdm.id,
        descricao: descricaoController.text,
        valor: _conversion.replaceCommaToDot(valorController.text));
  }

  void updateDespesaAdm() async {
    createDespesaAdm();

    setState(() {
      _isInAsyncCall = true;
    });
    try {
      var isUpdated =
          await widget.despesaAdmBloc.updateDespesaAdm(_updatedDespesaAdm);
      if (isUpdated != null) {
        setState(() {
          _isInAsyncCall = false;
          Messages().showOkDialog(context, 'DespesaAdm atualizado',
              'Despesa Adm ${descricaoController.text} atualizado com sucesso !',
              () {
            Navigator.of(context).pop();
            Navigator.pop(context);
          });
        });
      } else {
        setState(() {
          _isInAsyncCall = false;
        });
        Messages().showAlertDialog(context, 'Erro',
            'Ocorreu um erro ao tentar atualizar a despesa Adm.');
      }
    } catch (e) {
      setState(() {
        _isInAsyncCall = false;
      });
      Messages().showAlertDialog(context, 'Erro',
          'Ocorreu um erro ao tentar atualizar a despesaAdm.\nErro: $e');
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

  loadDespesaAdm() {
    if (widget.despesaAdm != null) {
      descricaoController.text = widget.despesaAdm.descricao.toString();
      valorController.text = widget.despesaAdm.valor.toString();
    }
  }
}
