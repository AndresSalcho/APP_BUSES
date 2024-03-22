// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projecto_app1/Usuario.dart';
import 'package:projecto_app1/apiHandler.dart';

class RegPage extends StatelessWidget {
  const RegPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset("res/home.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        RegBox(),
      ],
    );
  }
}

class RegBox extends StatefulWidget {
  const RegBox({super.key});

  @override
  State<RegBox> createState() => _RegBoxState();
}

class _RegBoxState extends State<RegBox> {
  final _formKey = GlobalKey<FormState>();
  String nom = "";
  String app = "";
  String ced = "";
  String tel = "";
  String direccion = "";
  String pass1 = "";
  String pass2 = "";

  apiHandler api = apiHandler();

  bool checkedValue = false;
  double h = 700;
  double w = 370;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 250,
                  child: TextFormField(
                      onSaved: (String? val) {
                        nom = val!;
                      },
                      decoration: InputDecoration(
                          hintText: "Nombre",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 2.0))))),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 250,
                  child: TextFormField(
                      onSaved: (String? val) {
                        app = val!;
                      },
                      decoration: InputDecoration(
                          hintText: "Apellidos",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 2.0))))),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 250,
                  child: TextFormField(
                      onSaved: (String? val) {
                        ced = val!;
                      },
                      decoration: InputDecoration(
                          hintText: "Cedula",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 2.0))))),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 250,
                  child: TextFormField(
                      onSaved: (String? val) {
                        tel = val!;
                      },
                      decoration: InputDecoration(
                          hintText: "Telefono",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 2.0))))),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 250,
                  child: TextFormField(
                      onSaved: (String? val) {
                        direccion = val!;
                      },
                      decoration: InputDecoration(
                          hintText: "Dirección",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 2.0))))),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 250,
                  child: TextFormField(
                      obscureText: true,
                      onSaved: (String? val) {
                        pass1 = val!;
                      },
                      decoration: InputDecoration(
                          hintText: "Contraseña",
                          icon: Icon(Icons.lock),
                          hintStyle:
                              TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 2.0))))),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 250,
                  child: TextFormField(
                      obscureText: true,
                      onSaved: (String? val) {
                        pass2 = val!;
                      },
                      decoration: InputDecoration(
                          hintText: "Confirmar Contraseña",
                          icon: Icon(Icons.lock),
                          hintStyle:
                              TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 2.0))))),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 250,
                  child: CheckboxListTile(
                    title: Text("Es discapacitado?"),
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        if (!checkedValue) {
                          checkedValue = true;
                        } else {
                          checkedValue = false;
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250,
                child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        Usuario temp = Usuario(
                            Cedula: int.parse(ced),
                            Nombre: nom,
                            Apellidos: app,
                            Telefono: int.parse(tel),
                            Direccion: direccion,
                            Contrasena: pass1,
                            Saldo: 0);
                        api.addUsuario(user: temp);
                        Navigator.pop(context);
                      } else {
                        print("Hubo un error al registrar el usuario");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 31, 31, 31)),
                      foregroundColor:
                          MaterialStatePropertyAll<Color>(Colors.white),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return Colors.white.withOpacity(0.04);
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed))
                            return Colors.white.withOpacity(0.12);
                          return null;
                        },
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text("Registrarse"),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      size: 40,
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return Colors.black.withOpacity(0.04);
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed))
                            return Colors.black.withOpacity(0.12);
                          return null;
                        },
                      ),
                    ),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
