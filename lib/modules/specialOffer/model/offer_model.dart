class OfferModel {
  final String title;
  final String description;
  final String value;
  final String image;

  OfferModel(
      {required this.title,
      required this.description,
      required this.value,
      required this.image});

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
        title: json['title'],
        description: json['description'],
        value: json['value'],
        image: json['image']);
  }
}
