class TvModel {
  final String title;
  final String description;
  final String value;
  final String image;

  TvModel({
    required this.title,
    required this.description,
    required this.value,
    required this.image,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) {
    return TvModel(
        title: json['title'],
        description: json['description'],
        value: json['value'],
        image: json['image']);
  }
}
