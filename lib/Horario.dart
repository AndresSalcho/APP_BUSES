class Horario {
  final int idHorario;
  final String Hora;
  final int idParada;
  final String Parada;
  final int CostoParada;
  final String BusSerie;

  const Horario(
      {required this.idHorario,
      required this.Hora,
      required this.idParada,
      required this.Parada,
      required this.CostoParada,
      required this.BusSerie});

  int getIdHorario() {
    return idHorario;
  }

  String getHora() {
    return Hora;
  }

  int getIdParada() {
    return idParada;
  }

  String getParada() {
    return Parada;
  }

  int getCostoParada() {
    return CostoParada;
  }

  String gatBusSerie() {
    return BusSerie;
  }

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
      idHorario: json['idHorario'],
      Hora: json['hora'],
      idParada: json['idParada'],
      Parada: json['parada'],
      CostoParada: json['costoParada'],
      BusSerie: json['busSerie']);
}
