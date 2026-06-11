class Pet {
  int? id; // Pode ser nulo inicialmente
  String nome;
  String raca;
  String nomeDono;
  String telefone;

  // Construtor
  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.nomeDono,
    required this.telefone,
  });

  // Mapeamento de dados do BD
  // ToMap
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "raca": raca,
      "nomeDono": nomeDono,
      "telefone": telefone,
    };
  }

  // FromMap
  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map["id"],
      nome: map["nome"],
      raca: map["raca"],
      nomeDono: map["nomeDono"],
      telefone: map["telefone"],
    );
  }
}
