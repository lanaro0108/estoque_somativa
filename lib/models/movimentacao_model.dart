class Movimentacao {
  int? id;
  int produtoId;
  String tipoMovimentacao;
  int quantidade;
  String dataHora;
  String observacao;

  Movimentacao({
    this.id,
    required this.produtoId,
    required this.tipoMovimentacao,
    required this.quantidade,
    required this.dataHora,
    required this.observacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'produtoId': produtoId,
      'tipoMovimentacao': tipoMovimentacao,
      'quantidade': quantidade,
      'dataHora': dataHora,
      'observacao': observacao,
    };
  }

  factory Movimentacao.fromMap(Map<String, dynamic> map) {
    return Movimentacao(
      id: map['id'],
      produtoId: map['produtoId'],
      tipoMovimentacao: map['tipoMovimentacao'],
      quantidade: map['quantidade'],
      dataHora: map['dataHora'],
      observacao: map['observacao'],
    );
  }
}

