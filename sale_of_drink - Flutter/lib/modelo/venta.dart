class Venta {
  late final int idven;
  late final String fecven;
  late final String tippagven;
  late final String estven;

  Venta({
    this.idven = 0,
    required this.fecven,
    required this.tippagven,
    required this.estven,
  });

  factory Venta.fromJson(Map<String, dynamic> json) {
    return Venta(
      idven: json['idven'],
      fecven: json['fecven'],
      tippagven: json['tippagven'],
      estven: json['estven'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idven': idven,
      'fecven': fecven,
      'tippagven': tippagven,
      'estven': estven,
    };
  }
}
