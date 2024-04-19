// ignore_for_file: file_names, non_constant_identifier_names

class Chofer {
  final int Cedula;
  final String Nombre;
  final String Apellidos;
  final int Telefono;
  final String Direccion;
  final String Contrasena;

  const Chofer(
      {required this.Cedula,
      required this.Nombre,
      required this.Apellidos,
      required this.Telefono,
      required this.Direccion,
      required this.Contrasena});

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

  @override
  String toString() => "$Cedula, $Nombre, $Apellidos, $Telefono";

  factory Chofer.fromJson(Map<String, dynamic> json) => Chofer(
      Cedula: json['cedula'],
      Nombre: json['nombre'],
      Apellidos: json['apellidos'],
      Telefono: json['telefono'],
      Direccion: json['direccion'],
      Contrasena: json['contrasena']);

  Map<String, dynamic> toJson() => {
        "Cedula": Cedula,
        "Nombre": Nombre,
        "Apellidos": Apellidos,
        "Telefono": Telefono,
        "Direccion": Direccion,
        "Contrasena": Contrasena
      };
}
