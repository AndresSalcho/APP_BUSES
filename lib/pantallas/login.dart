// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:projecto_app1/Chofer.dart';
import 'package:projecto_app1/Tiquete.dart';
import 'package:projecto_app1/apiHandler.dart';
import 'package:projecto_app1/pantallas/driverscreen.dart';
import 'package:projecto_app1/pantallas/forgotpass.dart';
import 'package:projecto_app1/pantallas/register.dart';
import 'package:projecto_app1/pantallas/mainscreen.dart';
import 'package:projecto_app1/Usuario.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset("res/home.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        const Text("\n\nBUSES ABC",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, decoration: TextDecoration.none)),
        LoginBox(
            h: MediaQuery.of(context).size.height * 0.40,
            w: MediaQuery.of(context).size.width * 0.80),
      ],
    );
  }
}

// ignore: must_be_immutable
class LoginBox extends StatefulWidget {
  double h;
  double w;
  LoginBox({super.key, required this.h, required this.w});

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  apiHandler api = apiHandler();
  List<Tiquete> data = [];
  Usuario? user;
  Chofer? driver;
  final _formKey = GlobalKey<FormState>();
  int ced = 0;
  String pass = "";
  bool valid = true;

  Future<bool> getUsuario() async {
    user = await api.getUsuario(ced, pass);
    return true;
  }

  Future<bool> getChofer() async {
    driver = await api.getChofer(ced, pass);
    return true;
  }

  Future<void> getHorario() async {
    await api.compraTiquete(208560486, 9, 1, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Container(
              constraints: const BoxConstraints(maxHeight: double.infinity),
              width: widget.w,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: TextFormField(
                          onSaved: (String? val) {
                            ced = int.parse(val!);
                          },
                          validator: (value) {
                            if (!valid) {
                              return 'Cedula o contraseña incorrecta';
                            } else {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese un dato';
                              }
                            }
                            valid = true;
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 0.6)),
                              icon: Icon(Icons.person),
                              hintText: "Cédula",
                              hintStyle:
                                  TextStyle(color: Color.fromARGB(60, 0, 0, 0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0))),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: TextFormField(
                            onSaved: (String? val) {
                              pass = val!;
                            },
                            validator: (value) {
                              if (!valid) {
                                return 'Cedula o contraseña incorrecta';
                              } else {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingrese un dato';
                                }
                              }
                              valid = true;
                              //h = 325;
                              return null;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                hintText: "Contraseña",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(60, 0, 0, 0)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0))))),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: TextButton(
                        onPressed: () async {
                          valid = true;
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ));
                                });
                            await getUsuario();
                            if (user != null) {
                              Route route = MaterialPageRoute(
                                  builder: (context) => MainPage(user: user));
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                  context, route, (route) => false);
                            } else {
                              await getChofer();
                              if (driver != null) {
                                Route route = MaterialPageRoute(
                                    builder: (context) =>
                                        DrivePage(driver: driver));
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                    context, route, (route) => false);
                              } else {
                                Navigator.pop(context);
                                setState(() {
                                  valid = false;
                                  _formKey.currentState!.validate();
                                });
                              }
                            }
                          } else {
                            setState(() {
                              //h = 380;
                            });
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
                        child: const Text("Iniciar Sesión"),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgottenPage()));
                        },
                        style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.black),
                          overlayColor: MaterialStatePropertyAll<Color>(
                              Colors.transparent),
                        ),
                        child: const Text("Olvidó la Contraseña?",
                            style: TextStyle(
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const RegPage()));
                            },
                            style: const ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.black),
                              overlayColor: MaterialStatePropertyAll<Color>(
                                  Colors.transparent),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Sin cuenta?  "),
                                Text("Registrarme",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline))
                              ],
                            ))),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
