class Persona {
  late final int idper;
  late final String nomper;
  late final String apeper;
  late final String celper;
  late final String corper;
  late final String dniper;
  late final String useper;
  late final String conper;
  late final String tipper;
  late final String estper;

  Persona({
    this.idper = 0,
    required this.nomper,
    required this.apeper,
    required this.celper,
    required this.corper,
    required this.dniper,
    this.useper = '',
    this.conper = '',
    this.tipper = '',
    required this.estper,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      idper: json['idper'],
      nomper: json['nomper'],
      apeper: json['apeper'],
      celper: json['celper'],
      corper: json['corper'],
      dniper: json['dniper'],
      useper: json['useper'],
      conper: json['conper'],
      tipper: json['tipper'],
      estper: json['estper'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idper': idper,
      'nomper': nomper,
      'apeper': apeper,
      'celper': celper,
      'corper': corper,
      'dniper': dniper,
      'useper': useper,
      'conper': conper,
      'tipper': tipper,
      'estper': estper,
    };
  }
}
