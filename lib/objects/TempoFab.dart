class TempoFab {
  int id;
  String descricao;
  double valorHora;

  TempoFab({this.id, this.descricao, this.valorHora});

  TempoFab fromMap(Map<dynamic, dynamic> json) {
    return TempoFab(
      id: json['id'],
      descricao: json['descricao'],
      valorHora: json['valorHora'],
    );
  }

  factory TempoFab.fromMap(dynamic key, Map<String, dynamic> json) =>
      new TempoFab(
        id: json['id'],
        descricao: json['descricao'],
        valorHora: json['valorHora'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'descricao': this.descricao,
      'valorHora': this.valorHora,
    };
  }
}

class TempoFabList {
  int id;
  double quant;

  TempoFabList(this.id, this.quant);

  TempoFabList fromMap(Map<dynamic, dynamic> json) {
    return TempoFabList(
      
      this.id = json['id'],
      this.quant = json['quant'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'quant': this.quant,
    };
  }
}