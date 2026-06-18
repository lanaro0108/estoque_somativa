class Produto {
  int? id;
  String nome;
  String descricao;
  double precoCusto;
  double precoVenda;
  int quantidadeEstoque;
  String codigo;

  Produto({
    this.id,
    required this.nome,
    required this.descricao,
    required this.precoCusto,
    required this.precoVenda,
    required this.quantidadeEstoque,
    required this.codigo,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "descricao": descricao,
      "precoCusto": precoCusto,
      "precoVenda": precoVenda,
      "quantidadeEstoque": quantidadeEstoque,
      "codigo": codigo,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map["id"],
      nome: map["nome"],
      descricao: map["descricao"],
      precoCusto: map["precoCusto"],
      precoVenda: map["precoVenda"],
      quantidadeEstoque: map["quantidadeEstoque"],
      codigo: map["codigo"],
    );
  }
}

