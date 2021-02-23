class Unidade {
  int id;
  String descricao;

  Unidade({this.id, this.descricao});

  Unidade fromMap(Map<dynamic, dynamic> json) {
    return Unidade(
      id: json['id'],
      descricao: json['descricao'],
    );
  }

  factory Unidade.fromMap(dynamic key, Map<String, dynamic> json) =>
      new Unidade(
        id: json['id'],
        descricao: json['descricao'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'descricao': this.descricao,
    };
  }
}
