class SelectedApp {
  final String name;
  final int price;
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
    this.benefitDetails = const[]
  });

  SelectedApp copyWith({
    String? name,
    int? price,
    String? image,
    bool? isVisible,
  }) {
    return SelectedApp(
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      isVisible: isVisible ?? this.isVisible,
      id: '',
    );
  }
}

class SelectedCombo {
  final String mega;
  final int megaPrice;
  final List<SelectedApp> apps;
  final int total;
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
    int? megaPrice,
    List<SelectedApp>? apps,
    int? total,
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


