class AdditionalModel {
  final String? id;
  final String? nome;
  final String? image;
  final Map<String, dynamic>? preco;
  final List<Map<String, dynamic>>? idPlans;

  const AdditionalModel({
    required this.id,
    required this.nome,
    required this.image,
    required this.preco,
    required this.idPlans,
  });

  factory AdditionalModel.fromJson(Map<String, dynamic> json) {
    return AdditionalModel(
      id: json['_id'],
      nome: json['nome'],
      image: json['image'],
      preco: json['preco'],
      idPlans: (json['idPlans'] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList(),
    );
  }
}
