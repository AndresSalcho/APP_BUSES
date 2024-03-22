import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgottenPage extends StatelessWidget {
  const ForgottenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset("res/home.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        Forgot(),
      ],
    );
  }
}

class Forgot extends StatelessWidget {
  const Forgot({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 200),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            width: 370,
            height: 280,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text("Favor ingresar su numero de cédula"),
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
                  width: 100,
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
                        child: Text("Enviar"),
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
                        style: ButtonStyle(overlayColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Colors.black.withOpacity(0.04);
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed))
                              return Colors.black.withOpacity(0.12);
                            return null;
                          },
                        )))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
