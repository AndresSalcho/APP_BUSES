class Vehiculo {
  final String BusSerie;
  final String placa;
  final String hora;
  final String direccion;
  final String LugarLlegada;
  final String LugarSalida;

  const Vehiculo(
      {required this.BusSerie,
      required this.placa,
      required this.hora,
      required this.direccion,
      required this.LugarLlegada,
      required this.LugarSalida});

  String getbusSerie() {
    return BusSerie;
  }

  String getPlaca() {
    return placa;
  }

  String getHora() {
    return hora;
  }

  String getDireccion() {
    return direccion;
  }

  String getLugarLL() {
    return LugarLlegada;
  }

  String getLugarS() {
    return LugarSalida;
  }

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
      BusSerie: json['busSerie'],
      placa: json['placa'],
      hora: json['hora'],
      direccion: json['direccion'],
      LugarLlegada: json['lugarLlegada'],
      LugarSalida: json['lugarSalida']);
}
