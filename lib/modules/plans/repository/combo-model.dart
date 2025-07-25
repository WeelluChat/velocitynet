class PlanoModel {
  final String nome;
  final int velocidade;
  final double valor;
  final bool isVisible;
  final List<BeneficioModel> beneficios;
  final List<DetalheModel> detalhes;

  PlanoModel({
    required this.nome,
    required this.velocidade,
    required this.valor,
    required this.isVisible,
    required this.beneficios,
    required this.detalhes,
  });

  factory PlanoModel.fromJson(Map<String, dynamic> json) {
    return PlanoModel(
      nome: json['nome'],
      velocidade: json['velocidade'],
      valor: (json['valor'] as num).toDouble(),
      isVisible: json['isVisible'] ?? true,
      beneficios: (json['beneficios'] as List)
          .map((b) => BeneficioModel.fromJson(b))
          .toList(),
      detalhes: (json['detalhes'] as List)
          .map((d) => DetalheModel.fromJson(d))
          .toList(),
    );
  }
}

class BeneficioModel {
  final String nome;
  final bool incluso;
  final bool isVisible;
  final double valor;
  final String image;

  BeneficioModel({
    required this.nome,
    required this.incluso,
    required this.isVisible,
    required this.valor,
    required this.image,
  });

  factory BeneficioModel.fromJson(Map<String, dynamic> json) {
    return BeneficioModel(
      nome: json['nome'],
      incluso: json['incluso'],
      isVisible: json['isVisible'] ?? true,
      valor: (json['valor'] as num).toDouble(),
      image: json['image'],
    );
  }
}

class DetalheModel {
  final String text;
  final int icon;

  DetalheModel({required this.text, required this.icon});

  factory DetalheModel.fromJson(Map<String, dynamic> json) {
    return DetalheModel(
      text: json['text'],
      icon: json['icon'],
    );
  }
}