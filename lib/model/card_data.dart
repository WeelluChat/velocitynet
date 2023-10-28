class CardData {
  final String title;
  final String description;
  final String icon;
  final bool validation;

  CardData(
      {required this.title,
      required this.description,
      required this.icon,
      required this.validation});

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      title: json['name'],
      description: json['description'],
      icon: json['logo'],
      validation: json['validation'],
    );
  }
}
