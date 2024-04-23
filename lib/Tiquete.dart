class Tiquete {
  int idPago;
  int cedulaCliente;
  String descripcipon;
  String fecha;
  String numeroSerieBus;
  int costo;
  String LugarLlegada;
  String LugarSalida;

  Tiquete(
      {required this.idPago,
      required this.cedulaCliente,
      required this.descripcipon,
      required this.fecha,
      required this.numeroSerieBus,
      required this.costo,
      required this.LugarLlegada,
      required this.LugarSalida});

  int getIdPago() {
    return idPago;
  }

  int getCedulaCliente() {
    return cedulaCliente;
  }

  String getDescripcion() {
    return descripcipon;
  }

  String getFecha() {
    return fecha;
  }

  String getSerieBus() {
    return numeroSerieBus;
  }

  int getCosto() {
    return costo;
  }

  String getLugarLL() {
    return LugarLlegada;
  }

  String getLugarS() {
    return LugarSalida;
  }

  factory Tiquete.fromJson(Map<String, dynamic> json) => Tiquete(
      idPago: json['idPago'],
      cedulaCliente: json['cedulaCliente'],
      descripcipon: json['descripcipon'],
      fecha: json['fecha'],
      numeroSerieBus: json['numeroSerieBus'],
      costo: json['costo'],
      LugarLlegada: json['lugarLlegada'],
      LugarSalida: json['lugarSalida']);
}
