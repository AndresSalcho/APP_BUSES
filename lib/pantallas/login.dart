import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        LoginBox(),
      ],
    );
  }
}

class LoginBox extends StatelessWidget {
  const LoginBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 200),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            width: 370,
            height: 325,
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
                    child: TextField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: "Cédula",
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
                    child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            hintText: "Contraseña",
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
                  child: TextButton(
                      onPressed: () {},
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
                        child: Text("Iniciar Sesión"),
                      )),
                ),
                SizedBox(
                  width: 250,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStatePropertyAll<Color>(Colors.black),
                      overlayColor:
                          MaterialStatePropertyAll<Color>(Colors.transparent),
                    ),
                    child: Text("Olvidó la Contraseña?",
                        style: TextStyle(decoration: TextDecoration.underline)),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black),
                        overlayColor:
                            MaterialStatePropertyAll<Color>(Colors.transparent),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Registrarme",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
