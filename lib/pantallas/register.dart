// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
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
        const Text("\nBUSES ABC",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, decoration: TextDecoration.none)),
        RegBox(
          w: MediaQuery.of(context).size.width * 0.85,
        ),
      ],
    );
  }
}

class RegBox extends StatefulWidget {
  final double w;
  const RegBox({super.key, required this.w});

  @override
  State<RegBox> createState() => _RegBoxState();
}

class _RegBoxState extends State<RegBox> {
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String nom = "";
  String app = "";
  String ced = "";
  String tel = "";
  String direccion = "";
  String pass1 = "";
  String pass2 = "";

  String aux = "";

  final TextEditingController cont = TextEditingController();

  bool exits = false;

  apiHandler api = apiHandler();

  bool checkedValue = false;

  Future<void> checkUser(int? user) async {
    user = await api.checkExists(user!);
    if (user == 1) {
      exits = true;
    } else {
      exits = false;
    }
  }

  bool checkNombre(String val) {
    RegExp reg = RegExp(r"^[A-Za-z\s]+$");
    return reg.hasMatch(val);
  }

  bool checkPhone(String val) {
    RegExp reg = RegExp(r"^\d{4}\d{4}$");
    return reg.hasMatch(val);
  }

  bool checkCed(String val) {
    RegExp reg = RegExp(r"^[1-7]0[0-9]{3}0[0-9]{3}$");
    return reg.hasMatch(val);
  }

  bool checkPass(String val) {
    RegExp reg = RegExp(r"^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}$");
    return reg.hasMatch(val);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: double.infinity),
          width: widget.w,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: TextFormField(
                          onSaved: (String? val) {
                            nom = val!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese un dato';
                            } else {
                              if (!checkNombre(value)) {
                                return 'Nombre no válido';
                              }
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Nombre",
                              hintStyle:
                                  TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0))))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: TextFormField(
                          onSaved: (String? val) {
                            app = val!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese un dato';
                            } else {
                              if (!checkNombre(value)) {
                                return 'Apellido no válido';
                              }
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Apellidos",
                              hintStyle:
                                  TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0))))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: TextFormField(
                          controller: myController,
                          onSaved: (String? val) {
                            ced = val!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese un dato';
                            } else {
                              if (!checkCed(value)) {
                                return 'Cédula no válida';
                              } else if (exits) {
                                return 'Cédula ya existe!';
                              }
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Cédula",
                              hintStyle:
                                  TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0))))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: TextFormField(
                          onSaved: (String? val) {
                            tel = val!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese un dato';
                            } else {
                              if (!checkPhone(value)) {
                                return 'Telefono no válido';
                              }
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Telefono",
                              hintStyle:
                                  TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0))))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: TextFormField(
                          onSaved: (String? val) {
                            direccion = val!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese un dato';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Dirección",
                              hintStyle:
                                  TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0))))),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: TextFormField(
                          obscureText: true,
                          onSaved: (String? val) {
                            pass1 = val!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese un dato';
                            } else {
                              if (!checkPass(value)) {
                                return 'Contraseña no válida';
                              }
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Contraseña",
                              icon: Icon(Icons.lock),
                              hintStyle:
                                  TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0))))),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: CheckboxListTile(
                        checkColor: Colors.white,
                        activeColor: Colors.black,
                        title: const Text(
                          "Es discapacitado?",
                          style: TextStyle(fontSize: 15),
                        ),
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
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.48,
                    child: TextButton(
                        onPressed: () async {
                          if (checkCed(myController.text)) {
                            checkUser(int.parse(myController.text));
                          }
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            Usuario temp = Usuario(
                                Cedula: int.parse(ced),
                                Nombre: nom,
                                Apellidos: app,
                                Telefono: int.parse(tel),
                                Direccion: direccion,
                                Contrasena: pass1,
                                Saldo: 0,
                                Discapacitado: checkedValue);
                            api.addUsuario(user: temp);
                            Navigator.pop(context);
                          } else {
                            print("Hubo un error al registrar el usuario");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Color.fromARGB(255, 31, 31, 31)),
                          foregroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.white),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.white.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.white.withOpacity(0.12);
                              }
                              return null;
                            },
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text("Registrarse"),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.black.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.black.withOpacity(0.12);
                              }
                              return null;
                            },
                          ),
                        ),
                        child: const Icon(
                          size: 40,
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
