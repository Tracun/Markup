class DespesaAdm {

    int? id;
    String? descricao;
    double? valor; //Valor hora

    DespesaAdm({
      this.id,
      this.descricao,
      this.valor
    });

      DespesaAdm fromMap(Map<dynamic, dynamic> json) {
    return DespesaAdm(
      id: json['id'],
      descricao: json['descricao'],
      valor: json['valor'],
    );
  }

  factory DespesaAdm.fromMap(Map<String, dynamic> json) => new DespesaAdm(
      id: json['id'],
      descricao: json['descricao'],
      valor: json['valor'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'descricao': this.descricao,
      'valor': this.valor,
    };
  }
}

class DespesaAdmList {
  int id;
  double quant;
  String descricao;

  DespesaAdmList(this.id, this.quant, this.descricao);

  DespesaAdmList fromMap(Map<dynamic, dynamic> json) {
    return DespesaAdmList(
      
      this.id = json['id'],
      this.quant = json['quant'],
      this.descricao = json['descricao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'quant': this.quant,
      'descricao': this.descricao,
    };
  }
}