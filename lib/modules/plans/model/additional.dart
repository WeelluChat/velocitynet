class AdditionalModel {
  final String? id;
  final String? nome;
  final String? image;
  final Map<String, dynamic>? preco;
  final String idPlan;

  const AdditionalModel({
    required this.id,
    required this.nome,
    required this.image,
    required this.preco,
    required this.idPlan,
  });

  factory AdditionalModel.fromJson(Map<String, dynamic> json) {
    return AdditionalModel(
      id: json['_id'],
      nome: json['nome'],
      image: json['image'],
      preco: json['preco'],
      idPlan: json['idPlan'],
    );
  }
}
