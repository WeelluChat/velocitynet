class SelectedApp {
  final String name;
  final double price;
  final String image;
  final bool isVisible;
  final String id;
  final int minPlan;
  final String color;
  final List<String> benefitDetails;
  final bool isMultiple;
  final bool incluso; // ✅ ADICIONADO: Novo campo 'incluso'
  final int quantity;

  SelectedApp({
    required this.name,
    required this.price,
    required this.image,
    required this.isVisible,
    required this.id,
    this.minPlan = 0,
    this.color = '',
    this.benefitDetails = const [],
    this.isMultiple = false,
    this.incluso = false,
    this.quantity = 1,
  });

  SelectedApp copyWith({
    String? name,
    double? price,
    String? image,
    bool? isVisible,
    String? id,
    int? minPlan,
    String? color,
    List<String>? benefitDetails,
    bool? isMultiple,
    bool? incluso,
    int? quantity,
  }) {
    return SelectedApp(
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      isVisible: isVisible ?? this.isVisible,
      id: id ?? this.id,
      minPlan: minPlan ?? this.minPlan,
      color: color ?? this.color,
      benefitDetails: benefitDetails ?? this.benefitDetails,
      isMultiple: isMultiple ?? this.isMultiple,
      incluso: incluso ?? this.incluso,
      quantity: quantity ?? this.quantity,
    );
  }
}

class SelectedCombo {
  final String mega;
  final double megaPrice;
  final List<SelectedApp> apps;
  final double total;
  final bool isVisible;

  SelectedCombo({
    required this.mega,
    required this.megaPrice,
    required this.apps,
    required this.total,
    required this.isVisible,
  });

  SelectedCombo copyWith({
    String? mega,
    double? megaPrice,
    List<SelectedApp>? apps,
    double? total,
    bool? isVisible,
  }) {
    return SelectedCombo(
      mega: mega ?? this.mega,
      megaPrice: megaPrice ?? this.megaPrice,
      apps: apps ?? this.apps,
      total: total ?? this.total,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}