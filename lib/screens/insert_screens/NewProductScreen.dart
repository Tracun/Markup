import 'dart:io';
import 'package:calcular_preco_venda/bloc/ProductBloc.dart';
import 'package:calcular_preco_venda/services/calculation.dart';
import 'package:calcular_preco_venda/utils/Buttom.dart';
import 'package:calcular_preco_venda/utils/Conversion.dart';
import 'package:calcular_preco_venda/utils/HeaderWidget.dart';
import 'package:calcular_preco_venda/utils/Message.dart';
import 'package:calcular_preco_venda/utils/MyColors.dart';
import 'package:calcular_preco_venda/utils/SharedPrefs.dart';
import 'package:calcular_preco_venda/widgets/AdmobWidget.dart';
import 'package:flutter/material.dart';
import 'package:calcular_preco_venda/objects/Product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class NewProductScreen extends StatefulWidget {
  final ProductBloc productBloc;

  NewProductScreen(this.productBloc);
  @override
  _NewProductScreenState createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final TextEditingController nameController = new TextEditingController();

  final TextEditingController encargoController = new TextEditingController();

  final TextEditingController custoController = new TextEditingController();

  // final TextEditingController valueRepresentanteController =
  //     new TextEditingController();

  final TextEditingController comissaoController = new TextEditingController();
  final TextEditingController lucroController = new TextEditingController();
  final TextEditingController imp1Controller = new TextEditingController();
  final TextEditingController imp2Controller = new TextEditingController();
  final TextEditingController outrosController = new TextEditingController();
  final TextEditingController custoIndiretoController =
      new TextEditingController();
  final TextEditingController precoForaController = new TextEditingController();
  final TextEditingController precoDentroController =
      new TextEditingController();
  final TextEditingController uriImgController = new TextEditingController();

  final Messages message = new Messages();
  bool _isInAsyncCall = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  File? _image;
  String? uriImg;
  late double valorVendaHosp;
  late double valorMargemLiqHosp;
  late double porcMargemLiqHosp;

  late double valorVendaRepr;
  late double valorMargemLiqRepr;
  late double porcMargemLiqRepr;
  late Product product;
  Conversion _conversion = new Conversion();

  static var riKeys1 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// Widgets para os campos

    final nameField = TextFormField(
      controller: nameController,
      validator: (value) {
        if (value!.isEmpty) {
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
        if (value!.isEmpty) {
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

    final encargoField = TextFormField(
      controller: encargoController,
      keyboardType: TextInputType.text,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Encargo %",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

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
        if (value!.isEmpty) {
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
    final imp1Field = TextFormField(
      controller: imp1Controller,
      keyboardType: TextInputType.number,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Imposto 1 %",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    // Despesas variaveis
    final imp2Field = TextFormField(
      controller: imp2Controller,
      keyboardType: TextInputType.number,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Imposto 2 %",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final outrosField = TextFormField(
      controller: outrosController,
      keyboardType: TextInputType.number,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Outros % ",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    // Valor percentual referente ao rateio de despesa fixa a ser incluida no preco do produto
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

    // Precos de venda
    final precoForaField = TextFormField(
      controller: precoForaController,
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

    final precoDentroField = TextFormField(
      controller: precoDentroController,
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

    final newProductButton = SimpleRoundButtonGrad(
      colors: [MyColors().appBarColor(), MyColors().buttonColor()],
      textColor: Colors.white,
      splashColor: Colors.white,
      buttonText: "Cadastrar",
      onPressed: () {
        if (!riKeys1.currentState!.validate()) {
        } else {
          insertProduct();
        }
      },
    );

    final calculateButton = SimpleRoundButtonGrad(
      colors: [MyColors().appBarColor(), MyColors().buttonColor()],
      textColor: Colors.white,
      splashColor: Colors.white,
      buttonText: "Calcular",
      onPressed: () {
        if (!riKeys1.currentState!.validate()) {
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
                              _image!,
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
        comissaoField,
        SizedBox(height: 15.0),
        imp1Field,
        SizedBox(height: 15.0),
        imp2Field,
        SizedBox(height: 15.0),
        encargoField,
        SizedBox(height: 15.0),
        outrosField,
        SizedBox(height: 15.0),
        custoIndiretoField,
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.only(top: 1, bottom: 1),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: HeaderWidget(
                    title: "Preço dentro",
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  child: HeaderWidget(
                    title: "Preço fora",
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: precoForaField,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  child: precoDentroField,
                ),
              ),
            ],
          ),
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
          title: new Text("Cadastro de produtos"),
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
                                  child: newProductButton,
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
    PickedFile? pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    File? image = pickedFile != null ? new File(pickedFile.path) : null;

    setState(() {
      image != null ? _image = image : _image = null;
      _image != null ? uriImg = _image!.path : null;
    });
  }

  void createProduct() {
    product = new Product(
        id: 0,
        nome: nameController.text,
        custo: _conversion.replaceCommaToDot(custoController.text),
        encargo: encargoController.text.isEmpty
            ? 0
            : _conversion.replaceCommaToDot(encargoController.text),
        comissao: comissaoController.text.isEmpty
            ? 0
            : _conversion.replaceCommaToDot(comissaoController.text),
        lucro: _conversion.replaceCommaToDot(lucroController.text),
        outros: outrosController.text.isEmpty
            ? 0
            : _conversion.replaceCommaToDot(outrosController.text),
        imp1: imp1Controller.text.isEmpty
            ? 0
            : _conversion.replaceCommaToDot(imp1Controller.text),
        imp2: imp2Controller.text.isEmpty
            ? 0
            : _conversion.replaceCommaToDot(imp2Controller.text),
        custoIndireto: custoIndiretoController.text.isEmpty
            ? 0
            : _conversion.replaceCommaToDot(custoIndiretoController.text),
        uriImg: uriImg);

    calculate();
  }

  void insertProduct() async {
    createProduct();

    setState(() {
      // _isInAsyncCall = true;
    });
    try {
      var isCreate = await widget.productBloc.newProduct(product);
      if (isCreate > 0) {
        await SharedPrefs().setDBChange(true);
        setState(() {
          _isInAsyncCall = false;
          Messages().showAlertDialog(context, 'Produto criado',
              'Produto ${nameController.text} criado com sucesso !');

          nameController.clear();
          encargoController.clear();
          precoForaController.clear();
          precoDentroController.clear();
          uriImgController.clear();
          precoForaController.clear();
          custoController.clear();
          lucroController.clear();
          imp2Controller.clear();
          imp1Controller.clear();
          custoIndiretoController.clear();
          outrosController.clear();
          comissaoController.clear();
          _image = null;
        });
      } else {
        Messages().showAlertDialog(
            context, 'Erro', 'Ocorreu um erro ao tentar inserir o produto.');
      }
    } catch (e) {
      Messages().showAlertDialog(context, 'Erro',
          'Ocorreu um erro ao tentar inserir o produto.\nErro: $e');
    }
  }

  calculate() {
    //Chama os metodos para efetuar os calculos de preco
    double precoFora = Calculation().calcularPrecoFora(product);
    double precoDentro = Calculation().calcularPrecoDentro(product);

    if (precoFora == -333 || precoDentro == -333) {
      Messages().showAlertDialog(
          context, "Erro", "A soma das porcentagem não pode exceder 100%");
    } else {
      setState(() {
        product.precoDentro = precoDentro;
        product.precoFora = precoFora;

        precoDentroController.text = "R\$ ${precoDentro.toStringAsFixed(2)}";
        precoForaController.text = "R\$ ${precoFora.toStringAsFixed(2)}";
      });
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
}
