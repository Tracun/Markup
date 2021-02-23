class Rateio {
  int id;
  String descricao;
  double valor;

  Rateio(
      {this.id,
      this.descricao,
      this.valor,});

  Rateio fromMap(Map<dynamic, dynamic> json) {
    return Rateio(
      id: json['id'],
      descricao: json['descricao'],
      valor: json['valor'],
    );
  }

  factory Rateio.fromMap(dynamic key, Map<String, dynamic> json) => new Rateio(
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

class RateioList {
  int id;
  double porcentagemRateio;

  RateioList(this.id, this.porcentagemRateio);

  RateioList fromMap(Map<dynamic, dynamic> json) {
    return RateioList(
      
      this.id = json['id'],
      this.porcentagemRateio = json['porcentagemRateio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'porcentagemRateio': this.porcentagemRateio,
    };
  }
}