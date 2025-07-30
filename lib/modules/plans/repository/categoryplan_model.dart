class CategoryPlan {
  final String id;
  final String nome;
  final String logo;
  final bool isVisible;
  final List<CategoryImage> images;

  CategoryPlan({
    required this.id,
    required this.nome,
    required this.logo,
    required this.isVisible,
    required this.images,
  });

  factory CategoryPlan.fromJson(Map<String, dynamic> json) {
    return CategoryPlan(
      id: json['_id'] ?? '',
      nome: json['nome'] ?? '',
      logo: json['logo'] ?? '',
      isVisible: json['isVisible'] ?? true,
      images: (json['images'] as List? ?? [])
          .map((img) => CategoryImage.fromJson(img))
          .toList(),
    );
  }
}

class CategoryImage {
  final String filename;
  final bool isVisible;

  CategoryImage({
    required this.filename,
    required this.isVisible,
  });

  factory CategoryImage.fromJson(Map<String, dynamic> json) {
    return CategoryImage(
      filename: json['filename'] ?? '',
      isVisible: json['isVisible'] ?? true,
    );
  }
}