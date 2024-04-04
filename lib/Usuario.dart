// ignore_for_file: file_names, non_constant_identifier_names

class Usuario {
  final int Cedula;
  final String Nombre;
  final String Apellidos;
  final int Telefono;
  final String Direccion;
  final String Contrasena;
  final double Saldo;
  final bool Discapacitado;

  const Usuario(
      {required this.Cedula,
      required this.Nombre,
      required this.Apellidos,
      required this.Telefono,
      required this.Direccion,
      required this.Contrasena,
      required this.Saldo,
      required this.Discapacitado});

  int getCedula() {
    return Cedula;
  }

  String getNombre() {
    return Nombre;
  }

  String getApellidos() {
    return Apellidos;
  }

  int getTelefono() {
    return Telefono;
  }

  String getDireccion() {
    return Direccion;
  }

  double getSaldo() {
    return Saldo;
  }

  bool getDiscapacitado() {
    return Discapacitado;
  }

  @override
  String toString() => "$Cedula, $Nombre, $Apellidos, $Telefono";

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      Cedula: json['cedula'],
      Nombre: json['nombre'],
      Apellidos: json['apellidos'],
      Telefono: json['telefono'],
      Direccion: json['direccion'],
      Contrasena: json['contrasena'],
      Saldo: json['saldo'] + 0.0,
      Discapacitado: json['discapacitado']);

  Map<String, dynamic> toJson() => {
        "Cedula": Cedula,
        "Nombre": Nombre,
        "Apellidos": Apellidos,
        "Telefono": Telefono,
        "Direccion": Direccion,
        "Contrasena": Contrasena,
        "Saldo": Saldo,
        "Discapacitado": Discapacitado
      };
}
