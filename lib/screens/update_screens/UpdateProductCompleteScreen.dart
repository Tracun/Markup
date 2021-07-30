import 'dart:developer';
import 'dart:io';
import 'package:calcular_preco_venda/bloc/ProductComBloc.dart';
import 'package:calcular_preco_venda/objects/DespesaAdm.dart';
import 'package:calcular_preco_venda/objects/Insumo.dart';
import 'package:calcular_preco_venda/objects/ProductCom.dart';
import 'package:calcular_preco_venda/objects/Rateio.dart';
import 'package:calcular_preco_venda/objects/TempoFab.dart';
import 'package:calcular_preco_venda/services/Calculation.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Conversion.dart';
import 'package:calcular_preco_venda/utils/HeaderWidget.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/utils/SharedPrefs.dart';
import 'package:calcular_preco_venda/widgets/AdmobWidget.dart';
import 'package:calcular_preco_venda/widgets/TabBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UpdateProductCompleteScreen extends StatefulWidget {
  final ProductCom product;
  final ProductCompleteBloc productBloc;

  UpdateProductCompleteScreen(this.product, this.productBloc);
  @override
  _UpdateProductCompleteScreenState createState() =>
      _UpdateProductCompleteScreenState();
}

class _UpdateProductCompleteScreenState
    extends State<UpdateProductCompleteScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController custoController = new TextEditingController();
  final TextEditingController comissaoController = new TextEditingController();
  final TextEditingController lucroController = new TextEditingController();
  final TextEditingController lucroBrutoController =
      new TextEditingController();
  // final TextEditingController imp2Controller = new TextEditingController();
  final TextEditingController custoTotalController =
      new TextEditingController();
  final TextEditingController custoIndiretoController =
      new TextEditingController();
  final TextEditingController precoVendaController =
      new TextEditingController();
  final TextEditingController uriImgController = new TextEditingController();

  final Messages message = new Messages();
  bool _isInAsyncCall = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  File _image;
  String uriImg;
  double valorVendaHosp;
  double valorMargemLiqHosp;
  double porcMargemLiqHosp;

  double valorVendaRepr;
  double valorMargemLiqRepr;
  double porcMargemLiqRepr;
  ProductCom _updatedProduct;
  Conversion _conversion = new Conversion();
  Calculation calculation = new Calculation();

  List<InsumoList> selectedInsumoList = [];
  List<DespesaAdmList> selectedDespesaAdmList = [];
  List<int> selectedImpostoList = [];
  List<TempoFabList> selectedTempoFabList = [];
  List<RateioList> selectedRateioList = [];

  TabController _controller;

  static var riKeys1 = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    loadProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// Widgets para os campos

    final nameField = TextFormField(
      controller: nameController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Preencha o nome do produto';
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

    final custoField = TextFormField(
      controller: custoController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Custo do produto';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Custo produto",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    // final encargoField = TextFormField(
    //   controller: encargoController,
    //   keyboardType: TextInputType.text,
    //   style: style,
    //   decoration: InputDecoration(
    //     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //     hintText: "Encargo %",
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(32.0),
    //     ),
    //   ),
    // );

    final comissaoField = TextFormField(
      controller: comissaoController,
      keyboardType: TextInputType.number,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Comissão %",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    // Custo variavel
    final lucroField = TextFormField(
      controller: lucroController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Preencha o lucro';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Lucro %",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    // Porcentagem do lucro
    final lucroBrutoField = TextFormField(
      controller: lucroBrutoController,
      keyboardType: TextInputType.number,
      style: style,
      enabled: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "R\$ 0,00",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    // // Despesas variaveis
    // final imp2Field = TextFormField(
    //   controller: imp2Controller,
    //   keyboardType: TextInputType.number,
    //   style: style,
    //   decoration: InputDecoration(
    //     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //     hintText: "Imposto 2 %",
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(32.0),
    //     ),
    //   ),
    // );

    final custoTotalField = TextFormField(
      controller: custoTotalController,
      style: style,
      enabled: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "R\$ 0,00",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    // // Valor percentual referente ao rateio de despesa fixa a ser incluida no preco do produto
    final custoIndiretoField = TextFormField(
      controller: custoIndiretoController,
      keyboardType: TextInputType.number,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Custo indireto %",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    // // Precos de venda
    // final precoForaField = TextFormField(
    //   controller: precoForaController,
    //   style: style,
    //   enabled: false,
    //   decoration: InputDecoration(
    //     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //     hintText: "R\$ 0,00",
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(32.0),
    //     ),
    //   ),
    // );

    final precoVendaField = TextFormField(
      controller: precoVendaController,
      style: style,
      enabled: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "R\$ 0,00",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final updateProductButton = SimpleRoundButtonGrad(
      colors: [MyColors().appBarColor(), MyColors().buttonColor()],
      textColor: Colors.white,
      splashColor: Colors.white,
      buttonText: "Atualizar",
      onPressed: () {
        if (!riKeys1.currentState.validate()) {
        } else {
          createProduct();
          Future.delayed(Duration(seconds: 1, milliseconds: 300), () {
            log("DEPOIS");
            updateProduct();
          });
        }
      },
    );

    final calculateButton = SimpleRoundButtonGrad(
      colors: [MyColors().appBarColor(), MyColors().buttonColor()],
      textColor: Colors.white,
      splashColor: Colors.white,
      buttonText: "Calcular",
      onPressed: () {
        if (!riKeys1.currentState.validate()) {
        } else {
          createProduct();
        }
      },
    );

    final productImageWidget = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: MyColors().appBarColor(),
                  child: ClipOval(
                    child: new SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: (_image != null)
                          ? Image.file(
                              _image,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              "assets/noImage.gif",
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.camera,
                    size: 30.0,
                  ),
                  onPressed: () {
                    getImage();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final productValueForm = Column(
      children: [
        SizedBox(height: 15.0),
        custoField,
        SizedBox(height: 15.0),
        lucroField,
        SizedBox(height: 15.0),
        custoIndiretoField,
        SizedBox(height: 15.0),
        comissaoField,
        SizedBox(height: 15.0),
        // Tab widget para inserir os insumos, tempo de fabricacao etc.
        TabWidget(selectedInsumoList, selectedDespesaAdmList,
            selectedImpostoList, selectedRateioList, selectedTempoFabList),
        SizedBox(height: 18.0),
        SizedBox(
          child: HeaderWidget(
            title: "Custo total fabricação",
          ),
        ),
        custoTotalField,
        SizedBox(height: 15.0),
        SizedBox(
          child: HeaderWidget(
            title: "Preço Venda Markup",
          ),
        ),
        SizedBox(height: 15.0),
        SizedBox(
          child: precoVendaField,
        ),
        SizedBox(height: 15.0),
        SizedBox(
          child: HeaderWidget(
            title: "Lucro Bruto",
          ),
        ),
        SizedBox(height: 15.0),
        SizedBox(
          child: lucroBrutoField,
        ),
        SizedBox(height: 15.0),
      ],
    );

    final form = (Form(
      key: riKeys1,
      child: Column(
        children: <Widget>[
          productImageWidget,
          SizedBox(height: 15.0),
          nameField,
          SizedBox(height: 15.0),
          productValueForm,
        ],
      ),
    ));

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: MyColors().appBarColor(),
          automaticallyImplyLeading: true,
          title: new Text("Atualizar produto"),
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
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: calculateButton,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: SizedBox(
                                  child: updateProductButton,
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

  Future getImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    File image = pickedFile != null ? new File(pickedFile.path) : null;

    setState(() {
      image != null ? _image = image : _image = null;
      _image != null ? uriImg = _image.path : null;
    });
  }

  void createProduct() {
    setState(() {
      _isInAsyncCall = true;
    });
    
    _updatedProduct = new ProductCom(
        id: widget.product.id,
        despesaAdm: selectedDespesaAdmList,
        impostos: selectedImpostoList,
        insumos: selectedInsumoList,
        rateio: selectedRateioList,
        tempoFab: selectedTempoFabList,
        nome: nameController.text,
        precoVendaMarkup:
            _conversion.replaceCommaToDot(precoVendaController.text),
        custoTotalCalculado:
            _conversion.replaceCommaToDot(custoTotalController.text),
        custo: _conversion.replaceCommaToDot(custoController.text),
        lucro: _conversion.replaceCommaToDot(lucroController.text),
        custoIndireto: custoIndiretoController.text.isEmpty
            ? 0.0
            : _conversion.replaceCommaToDot(custoIndiretoController.text),
        comissao: comissaoController.text.isEmpty
            ? 0.0
            : _conversion.replaceCommaToDot(comissaoController.text),
        uriImg: uriImg);

    calculate();
  }

  calculate() async {
    calculation.restartValues();
    var valores = await calculation.calcularPrecoVendaMarkup(_updatedProduct);
    var pv = valores['pv'];
    var custoTotal = valores['custoTotal'];

    if (pv == -333) {
      _isInAsyncCall = false;
      Messages().showAlertDialog(context, "Erro ao calcular preço",
          "A soma das porcentagens (imposto/lucro/custoIndireto/comissão) não pode exceder 100%");
    }

    setState(() {
      custoTotalController.text = "R\$ ${custoTotal.toStringAsFixed(2)}";
      precoVendaController.text = "R\$ ${pv.toStringAsFixed(2)}";

      lucroBrutoController.text = "R\$ ${(pv - custoTotal).toStringAsFixed(2)}";
      _updatedProduct.precoVendaMarkup = double.parse(pv.toStringAsFixed(2));
      _updatedProduct.custoTotalCalculado =
          double.parse(custoTotal.toStringAsFixed(2));
      _isInAsyncCall = false;
    });
  }

  void updateProduct() async {
    setState(() {
      _isInAsyncCall = true;
    });
    try {
      log("widget: ${widget.productBloc}");
      var isUpdated = await widget.productBloc.updateProduct(_updatedProduct);
      log("isUpdated: $isUpdated");
      if (isUpdated != null) {
        await SharedPrefs().setDBChange(true);
        setState(() {
          _isInAsyncCall = false;
          Messages().showOkDialog(context, 'Produto atualizado',
              'Produto ${nameController.text} atualizado com sucesso !', () {
            Navigator.of(context).pop();
            Navigator.pop(context);
          });
        });
      } else {
        _isInAsyncCall = false;
        Messages().showAlertDialog(
            context, 'Erro', 'Ocorreu um erro ao tentar atualizar o produto.');
      }
    } catch (e) {
      _isInAsyncCall = false;
      Messages().showAlertDialog(context, 'Erro',
          'Ocorreu um erro ao tentar atualizar o produto.\nErro: $e');
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

  loadProduct() {
    if (widget.product != null) {
      // idController.text = widget.product.id.toString();
      nameController.text = widget.product.nome.toString();
      custoController.text =
          widget.product.custo == 0 ? "" : widget.product.custo.toString();
      comissaoController.text = widget.product.comissao == 0
          ? ""
          : widget.product.comissao.toString();
      lucroController.text =
          widget.product.lucro == 0 ? "" : widget.product.lucro.toString();

      custoIndiretoController.text = widget.product.custoIndireto == 0
          ? ""
          : widget.product.custoIndireto.toStringAsFixed(2);
      precoVendaController.text = widget.product.precoVendaMarkup == 0
          ? ""
          : "R\$ ${widget.product.precoVendaMarkup.toStringAsFixed(2)}";
      custoTotalController.text = widget.product.custoTotalCalculado == 0
          ? ""
          : "R\$ ${widget.product.custoTotalCalculado.toStringAsFixed(2)}";

      lucroBrutoController.text =
          "R\$ ${(widget.product.precoVendaMarkup - widget.product.custoTotalCalculado).toStringAsFixed(2)}";
      uriImg = widget.product.uriImg;

      selectedDespesaAdmList = widget.product.despesaAdm;
      selectedImpostoList = widget.product.impostos;
      selectedInsumoList = widget.product.insumos;
      selectedRateioList = widget.product.rateio;
      selectedTempoFabList = widget.product.tempoFab;
    }
  }
}
