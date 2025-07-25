class Combo {
  final String id;
  final String title;
  final bool isVisible;
  final List<Plan> planos;

  Combo({
    required this.id,
    required this.title,
    required this.isVisible,
    required this.planos,
  });

  factory Combo.fromJson(Map<String, dynamic> json) {
    var planosList = json['planos'] as List? ?? [];
    List<Plan> planos = planosList.map((p) => Plan.fromJson(p)).toList();

    return Combo(
      id: json['_id']?.toString() ?? '',
      title: json['title'] ?? '',
      isVisible: json['isVisible'] ?? true,
      planos: planos,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'isVisible': isVisible,
      'planos': planos.map((p) => p.toJson()).toList(),
    };
  }

  Combo copyWith({
    String? id,
    String? title,
    bool? isVisible,
    List<Plan>? planos,
  }) {
    return Combo(
      id: id ?? this.id,
      title: title ?? this.title,
      isVisible: isVisible ?? this.isVisible,
      planos: planos ?? this.planos,
    );
  }
}

class Plan {
  final String id;
  final String nome;
  final bool isVisible;
  final int velocidade;
  final double valor;
  final List<Beneficio> beneficios;
  final List<Detalhe> detalhes;

  Plan({
    required this.id,
    required this.nome,
    this.isVisible = true,
    required this.velocidade,
    required this.valor,
    required this.beneficios,
    required this.detalhes,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    var beneficiosList = json['beneficios'] as List? ?? [];
    List<Beneficio> beneficios = beneficiosList
        .map((b) => Beneficio.fromJson(b))
        .toList();

    var detalhesList = json['detalhes'] as List? ?? [];
    List<Detalhe> detalhes = detalhesList
        .map((d) => Detalhe.fromJson(d))
        .toList();

    return Plan(
      id: json['_id']?.toString() ?? '',
      nome: json['nome'] ?? '',
      isVisible: json['isVisible'] ?? true,
      velocidade: (json['velocidade'] as num?)?.toInt() ?? 0,
      valor: (json['valor'] as num?)?.toDouble() ?? 0.0,
      beneficios: beneficios,
      detalhes: detalhes,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'valor': valor,
    'velocidade': velocidade,
    'beneficios': beneficios.map((b) => b.toJson()).toList(),
    'detalhes': detalhes,
    'isVisible': isVisible,
  };

  Plan copyWith({
    String? id,
    String? nome,
    bool? isVisible,
    int? velocidade,
    double? valor,
    List<Beneficio>? beneficios,
    List<Detalhe>? detalhes,
  }) {
    return Plan(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      isVisible: isVisible ?? this.isVisible,
      velocidade: velocidade ?? this.velocidade,
      valor: valor ?? this.valor,
      beneficios: beneficios ?? this.beneficios,
      detalhes: detalhes ?? this.detalhes,
    );
  }
}

class Beneficio {
  final String id;
  final String nome;
  final bool isVisible;
  final double valor;
  final String image;

  Beneficio({
    required this.id,
    required this.nome,
    this.isVisible = true,
    required this.valor,
    required this.image,
  });

  factory Beneficio.fromJson(Map<String, dynamic> json) {
    return Beneficio(
      id: json['_id']?.toString() ?? '',
      nome: json['nome'] ?? '',
      isVisible: json['isVisible'] ?? true,
      valor: (json['valor'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'nome': nome,
      'isVisible': isVisible,
      'valor': valor,
      'image': image,
    };

    if (id.trim().isNotEmpty) {
      map['_id'] = id;
    }

    return map;
  }

  Beneficio copyWith({
    String? id,
    String? nome,
    bool? isVisible,
    double? valor,
    String? image,
  }) {
    return Beneficio(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      isVisible: isVisible ?? this.isVisible,
      valor: valor ?? this.valor,
      image: image ?? this.image,
    );
  }
}

class Detalhe {
  final String id;
  final String text;
  final int icon;

  Detalhe({this.id = '', required this.text, required this.icon});

  factory Detalhe.fromJson(Map<String, dynamic> json) {
    return Detalhe(
      id: json['_id']?.toString() ?? '',
      text: json['text'] ?? '',
      icon: (json['icon'] as num?)?.toInt() ?? 60213,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'text': text, 'icon': icon};

    if (id.trim().isNotEmpty) {
      map['_id'] = id;
    }

    return map;
  }

  Detalhe copyWith({String? id, String? text, int? icon}) {
    return Detalhe(
      id: id ?? this.id,
      text: text ?? this.text,
      icon: icon ?? this.icon,
    );
  }
}
