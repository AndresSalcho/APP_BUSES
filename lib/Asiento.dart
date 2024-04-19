class Asiento {
  final int idHorario;
  final String hora;
  final String direccionParada;
  final int costoParada;
  final String busSerie;
  final String estado;
  final int idAsiento;
  final bool ocupado;
  final bool exclusive;
  final int clientePresente;

  Asiento({
    required this.idHorario,
    required this.hora,
    required this.direccionParada,
    required this.costoParada,
    required this.busSerie,
    required this.estado,
    required this.idAsiento,
    required this.ocupado,
    required this.exclusive,
    required this.clientePresente,
  });

  int getIdHorario() {
    return idHorario;
  }

  String getHora() {
    return hora;
  }

  String getParada() {
    return direccionParada;
  }

  int getCostoParada() {
    return costoParada;
  }

  String getBusSerie() {
    return busSerie;
  }

  String getEstado() {
    return estado;
  }

  int getIdAsiento() {
    return idAsiento;
  }

  bool getOcupado() {
    return ocupado;
  }

  bool getExclusivo() {
    return exclusive;
  }

  int getPresente() {
    return clientePresente;
  }

  factory Asiento.fromJson(Map<String, dynamic> json) => Asiento(
      idHorario: json['idHorario'],
      hora: json['hora'],
      direccionParada: json['direccionParada'],
      costoParada: json['costoParada'],
      busSerie: json['busSerie'],
      estado: json['estado'],
      idAsiento: json['idAsiento'],
      ocupado: json['ocupado'],
      exclusive: json['exclusive'],
      clientePresente: json['clientePresente']);
}
