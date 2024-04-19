// ignore_for_file: avoid_print, camel_case_types

import 'dart:convert';
import 'package:projecto_app1/Asiento.dart';
import 'package:projecto_app1/Chofer.dart';
import 'package:projecto_app1/Horario.dart';
import 'package:projecto_app1/Tiquete.dart';
import 'package:projecto_app1/Usuario.dart';
import 'package:http/http.dart' as http;

class apiHandler {
  Future<List<Usuario>> getAll() async {
    List<Usuario> datos = [];
    var url = Uri.parse("https://192.168.100.217:7064/api/Query/getAll");

    try {
      http.Response response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        datos = jsonData.map((json) => Usuario.fromJson(json)).toList();
      } else {
        print('Fallo en el query: ${response.statusCode}.');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Hubo un error al obtener los datos: $e');
    }
    return datos;
  }

  Future<void> addUsuario({required Usuario user}) async {
    var url = Uri.parse("https://192.168.100.217:7064/api/Query/addUser");
    Map<String, String> headers = {"Content-type": "application/json"};

    String jsonBody = json.encode(user.toJson());

    try {
      http.Response response =
          await http.post(url, headers: headers, body: jsonBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = json.decode(response.body);
        print('Usuario creado: $responseData');
      } else {
        print('Fallo en el Query ${response.statusCode}.');
      }
    } catch (e) {
      print('Hubo un error al enviar los datos: $e');
    }
  }

  Future<Usuario?> getUsuario(int ced, String pass) async {
    var url = Uri.parse(
        "https://192.168.100.217:7064/api/Query/getUser?cedula=$ced&contrasena=$pass");
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return Usuario.fromJson(data);
      } else {
        print('Failed to query user: ${response.statusCode}.');
        return null;
      }
    } catch (e) {
      print('There was an error getting the data: $e');
      return null;
    }
  }

  Future<Chofer?> getChofer(int ced, String pass) async {
    var url = Uri.parse(
        "https://192.168.100.217:7064/api/Query/getChofer?cedula=$ced&contrasena=$pass");
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return Chofer.fromJson(data);
      } else {
        print('Failed to query driver: ${response.statusCode}.');
        return null;
      }
    } catch (e) {
      print('There was an error getting the data: $e');
      return null;
    }
  }

  Future<int?> checkExists(int ced) async {
    var url = Uri.parse(
        "https://192.168.100.217:7064/api/Query/checkExists?cedula=$ced");
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        print('Failed to query data: ${response.statusCode}.');
        return null;
      }
    } catch (e) {
      print('There was an error getting the data: $e');
      return null;
    }
  }

  Future<void> updateSaldo(int ced, double ammount) async {
    var url = Uri.parse(
        "https://192.168.100.217:7064/api/Query/updateSaldo?cedula=$ced&ammount=$ammount");
    try {
      http.Response response = await http.post(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = json.decode(response.body);
        print('Exito: $responseData');
      } else {
        print('Fallo en el Query ${response.statusCode}.');
      }
    } catch (e) {
      print('Hubo un error al enviar los datos: $e');
    }
  }

  Future<List<Horario>> getHorario() async {
    List<Horario> datos = [];
    var url = Uri.parse("https://192.168.100.217:7064/api/Query/getHorario");

    try {
      http.Response response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        datos = jsonData.map((json) => Horario.fromJson(json)).toList();
      } else {
        print('Fallo en el query: ${response.statusCode}.');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Hubo un error al obtener los datos: $e');
    }
    return datos;
  }

  Future<List<Asiento>> getAsiento(int parada, int horario) async {
    List<Asiento> datos = [];
    var url = Uri.parse(
        "https://192.168.100.217:7064/api/Query/getAsiento?parada=$parada&horario=$horario");

    try {
      http.Response response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        datos = jsonData.map((json) => Asiento.fromJson(json)).toList();
      } else {
        print('Fallo en el query: ${response.statusCode}.');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Hubo un error al obtener los datos: $e');
    }
    return datos;
  }

  Future<List<Tiquete>> getTiquete(int cedula) async {
    List<Tiquete> datos = [];
    var url = Uri.parse(
        "https://192.168.100.217:7064/api/Query/getTiquete?cedula=$cedula");

    try {
      http.Response response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        datos = jsonData.map((json) => Tiquete.fromJson(json)).toList();
      } else {
        print('Fallo en el query: ${response.statusCode}.');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Hubo un error al obtener los datos: $e');
    }
    return datos;
  }

  Future<void> compraTiquete(
      int ced, int asiento, int parada, int horario) async {
    var url = Uri.parse(
        "https://192.168.100.217:7064/api/Query/compraTiquete?cedula=$ced&asiento=$asiento&parada=$parada&horario=$horario");
    try {
      http.Response response = await http.post(url);
      if (response.statusCode == 400) {
        var responseData = json.decode(response.body);
        print('Exito: $responseData');
      } else {
        print('Fallo en el Query ${response.statusCode}.');
      }
    } catch (e) {
      print('Hubo un error al enviar los datos: $e');
    }
  }
}
