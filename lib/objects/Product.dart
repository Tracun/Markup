class Product {
  int id;
  String nome;
  double custo;
  double encargo;
  double comissao;
  double lucro;
  double outros;
  double imp1;
  double imp2;
  double custoIndireto;
  double precoFora;
  double precoDentro;
  String uriImg;

  Product(
      {this.id,
      this.nome,
      this.custo,
      this.encargo,
      this.comissao,
      this.lucro,
      this.outros,
      this.imp1,
      this.imp2,
      this.custoIndireto,
      this.precoFora,
      this.precoDentro,
      this.uriImg});

  // int get id => this.id;

  // String get nome => this.nome;
  // set nome(String nome) => this.nome = nome;

  // double get custo => this.custo;
  // set custo(double custo) => this.custo = custo;

  // double get encargo => this.encargo;
  // set encargo(double encargo) => this.encargo = encargo;

  // double get comissao => this.comissao;
  // set comissao(double comissao) => this.comissao = comissao;

  // double get lucro => this.lucro;
  // set lucro(double lucro) => this.lucro = lucro;

  // double get outros => this.outros;
  // set outros(double outros) => this.outros = outros;

  // double get imp1 => this.imp1;
  // set imp1(double imp1) => this.imp1 = imp1;

  // double get imp2 => this.imp2;
  // set imp2(double imp2) => this.imp2 = imp2;

  // double get custoIndireto => this.custoIndireto;
  // set custoIndireto(double custoIndireto) =>
  //     this.custoIndireto = custoIndireto;

  // double get precoFora => this.precoFora;
  // set precoFora(double precoFora) => this.precoFora = precoFora;

  // double get precoDentro => this.precoDentro;
  // set precoDentro(double precoDentro) => this.precoDentro = precoDentro;

  // String get uriImg => this.uriImg;
  // set uriImg(String uriImg) => this.uriImg = uriImg;

  Product fromMap(Map<dynamic, dynamic> json) {
    return Product(
      id: json['id'],
      nome: json['nome'],
      custo: json['custo'],
      encargo: json['encargo'],
      comissao: json['comissao'],
      lucro: json['lucro'],
      outros: json['outros'],
      imp1: json['imp1'],
      imp2: json['imp2'],
      custoIndireto: json['custoIndireto'],
      precoFora: json['precoFora'],
      precoDentro: json['precoDentro'],
      uriImg: json['uriImg'],
    );
  }

  factory Product.fromMap(Map<String, dynamic> json) => new Product(
      id: json['id'],
      nome: json['nome'],
      custo: json['custo'],
      encargo: json['encargo'],
      comissao: json['comissao'],
      lucro: json['lucro'],
      outros: json['outros'],
      imp1: json['imp1'],
      imp2: json['imp2'],
      custoIndireto: json['custoIndireto'],
      precoFora: json['precoFora'],
      precoDentro: json['precoDentro'],
      uriImg: json['uriImg'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'nome': this.nome,
      'custo': this.custo,
      'encargo': this.encargo,
      'comissao': this.comissao,
      'lucro': this.lucro,
      'outros': this.outros,
      'imp1': this.imp1,
      'imp2': this.imp2,
      'custoIndireto': this.custoIndireto,
      'precoFora': this.precoFora,
      'precoDentro': this.precoDentro,
      'uriImg': this.uriImg
    };
  }
}
