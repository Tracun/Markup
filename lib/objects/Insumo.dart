class Insumo {
  int? id;
  String? nome;
  int? idUnid;
  double? valorUnitario;

  Insumo({
    this.id,
    this.nome,
    this.idUnid,
    this.valorUnitario,
  });

  Insumo fromMap(Map<dynamic, dynamic> json) {
    return Insumo(
      id: json['id'],
      nome: json['nome'],
      idUnid: json['idUnid'],
      valorUnitario: json['valorUnitario'],
    );
  }

  factory Insumo.fromMap(dynamic key, Map<String, dynamic> json) => new Insumo(
        id: json['id'],
        nome: json['nome'],
        idUnid: json['idUnid'],
        valorUnitario: json['valorUnitario'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'nome': this.nome,
      'idUnid': this.idUnid,
      'valorUnitario': this.valorUnitario,
    };
  }
}

class InsumoList {
  int id;
  double quant;
  String name;

  InsumoList(this.id, this.quant, this.name);

  InsumoList fromMap(Map<dynamic, dynamic> json) {
    return InsumoList(
      this.id = json['id'],
      this.quant = json['quant'],
      this.name = json['name'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'id': this.id,
      'quant': this.quant,
      'name': this.name,
    };
  }
}
