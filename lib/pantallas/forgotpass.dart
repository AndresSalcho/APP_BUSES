import 'package:flutter/material.dart';

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
        const Text("\n\nBUSES ABC",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, decoration: TextDecoration.none)),
        Forgot(w: MediaQuery.of(context).size.width * 0.65),
      ],
    );
  }
}

class Forgot extends StatefulWidget {
  final double w;
  const Forgot({super.key, required this.w});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                constraints: const BoxConstraints(maxHeight: double.infinity),
                width: widget.w,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    const Text("Favor ingresar su numero de cédula"),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese un dato';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                icon: Icon(Icons.person),
                                hintText: "Cédula",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(60, 0, 0, 0)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0))))),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Route route = MaterialPageRoute(
                                  builder: (context) => const ForgottenPage());
                              Navigator.pushReplacement(context, route);
                            } else {
                              setState(() {});
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
                            child: Text("Enviar"),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(overlayColor:
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
                            )),
                            child: const Icon(
                              size: 40,
                              Icons.arrow_back,
                              color: Colors.black,
                            ))),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
