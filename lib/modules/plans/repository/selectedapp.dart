class SelectedApp {
  final String name;
  final double price; // <-- Alterado para double
  final String image;
  final bool isVisible;
  final String id;
  final int minPlan;
  final String color;
  final List<String> benefitDetails;

  SelectedApp({
    required this.name,
    required this.price,
    required this.image,
    required this.isVisible,
    required this.id,
    this.minPlan = 0,
    this.color = '',
    this.benefitDetails = const [],
  });

  SelectedApp copyWith({
    String? name,
    double? price, // <-- Alterado para double
    String? image,
    bool? isVisible,
    String? id, // <-- Adicionado id para o copyWith
  }) {
    return SelectedApp(
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      isVisible: isVisible ?? this.isVisible,
      id: id ?? this.id,
      minPlan: minPlan, // <-- Adicionado para o copyWith
      color: color, // <-- Adicionado para o copyWith
      benefitDetails: benefitDetails, // <-- Adicionado para o copyWith
    );
  }
}

class SelectedCombo {
  final String mega;
  final double megaPrice; // <-- Alterado para double
  final List<SelectedApp> apps;
  final double total; // <-- Alterado para double
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
    double? megaPrice, // <-- Alterado para double
    List<SelectedApp>? apps,
    double? total, // <-- Alterado para double
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