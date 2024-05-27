class PlanModel {
  final String? id;
  final String? nome;
  final String? imagem;
  final String? planoBase;
  final String? descricao;
  final String? idCategoria;
  final Map<String, dynamic>? preco;
  final List<Map<String, dynamic>>? complementar;

  const PlanModel({
    required this.id,
    required this.nome,
    required this.imagem,
    required this.planoBase,
    required this.descricao,
    required this.idCategoria,
    required this.preco,
    required this.complementar,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['_id'],
      nome: json['nome'],
      imagem: json['imagem'],
      planoBase: json['planoBase'],
      descricao: json['descricao'],
      idCategoria: json['idCategoria'],
      preco: json['preco'],
      complementar: (json['complementar'] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList(),
    );
  }
}
