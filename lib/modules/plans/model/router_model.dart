class RouterModel {
  final String? id;
  final Map<String, dynamic>? preco;

  const RouterModel({
    required this.id,
    required this.preco,
  });

  factory RouterModel.fromJson(Map<String, dynamic> json) {
    return RouterModel(
      id: json['_id'],
      preco: json['preco'],
    );
  }
}
