class Imposto {

    int id;
    String descricao;
    double porcentagem;

    Imposto({
      this.id,
      this.descricao,
      this.porcentagem
    });

      Imposto fromMap(Map<dynamic, dynamic> json) {
    return Imposto(
      id: json['id'],
      descricao: json['descricao'],
      porcentagem: json['porcentagem'],
    );
  }

  factory Imposto.fromMap(Map<String, dynamic> json) => new Imposto(
      id: json['id'],
      descricao: json['descricao'],
      porcentagem: json['porcentagem'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'descricao': this.descricao,
      'porcentagem': this.porcentagem,
    };
  }
}
