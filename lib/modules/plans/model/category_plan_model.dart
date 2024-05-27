class CategoryPlan {
  final String? id;
  final String? nome;
  final String? logo;
  final String? subTitulo;
  final String? visualizacao;

  const CategoryPlan({
    required this.id,
    required this.nome,
    required this.logo,
    required this.subTitulo,
    required this.visualizacao,
  });

  factory CategoryPlan.fromJson(Map<String, dynamic> json) {
    return CategoryPlan(
      id: json['_id'],
      nome: json['nome'],
      logo: json['logo'],
      subTitulo: json['subTitulo'],
      visualizacao: json['visualizacao'],
    );
  }
}
