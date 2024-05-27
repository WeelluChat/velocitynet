class ComplementModel {
  final String? id;
  final String? nome;
  final String? image;
  // final String? idPlan;

  const ComplementModel({
    required this.id,
    required this.nome,
    required this.image,
    // required this.idPlan,
  });

  factory ComplementModel.fromJson(Map<String, dynamic> json) {
    return ComplementModel(
      id: json['_id'],
      nome: json['nome'],
      image: json['image'],
      // idPlan: json['idPlan'],
    );
  }
}
