// ignore_for_file: avoid_print
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projecto_app1/apiHandler.dart';
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
        Text("\n\nBUSES ABC",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, decoration: TextDecoration.none)),
        LoginBox(),
      ],
    );
  }
}

// ignore: must_be_immutable
class LoginBox extends StatefulWidget {
  const LoginBox({super.key});

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  apiHandler api = apiHandler();
  List<Usuario> data = [];
  Usuario? user;
  final _formKey = GlobalKey<FormState>();
  int ced = 0;
  String pass = "";
  bool valid = true;

  double h = 325;
  double w = 370;

  Future<bool> getUsuario() async {
    user = await api.getUsuario(ced, pass);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 200),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: 250,
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
                            h = 325;
                            return null;
                          },
                          decoration: InputDecoration(
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
                      height: 20,
                    ),
                    SizedBox(
                        width: 250,
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
                              h = 325;
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                hintText: "Contraseña",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(60, 0, 0, 0)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0))))),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextButton(
                          onPressed: () async {
                            valid = true;
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              await getUsuario();
                              if (user != null) {
                                Route route = MaterialPageRoute(
                                    builder: (context) => MainPage(user: user));
                                Navigator.pushReplacement(context, route);
                              } else {
                                setState(() {
                                  valid = false;
                                  _formKey.currentState!.validate();
                                });
                              }
                            } else {
                              setState(() {
                                h = 380;
                              });
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromARGB(255, 31, 31, 31)),
                            foregroundColor:
                                MaterialStatePropertyAll<Color>(Colors.white),
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
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
                            child: Text("Iniciar Sesión"),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgottenPage()));
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.black),
                          overlayColor: MaterialStatePropertyAll<Color>(
                              Colors.transparent),
                        ),
                        child: Text("Olvidó la Contraseña?",
                            style: TextStyle(
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegPage()));
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll<Color>(Colors.black),
                            overlayColor: MaterialStatePropertyAll<Color>(
                                Colors.transparent),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(0),
                              child: Row(
                                children: [
                                  Text("    No tiene cuenta?  "),
                                  Text("Registrarme",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline))
                                ],
                              ))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
