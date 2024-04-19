// ignore_for_file: type_init_formals, avoid_print, must_be_immutable
import 'package:flutter/material.dart';
import 'package:projecto_app1/Horario.dart';
import 'package:projecto_app1/Tiquete.dart';
import 'package:projecto_app1/Chofer.dart';
import 'package:projecto_app1/apiHandler.dart';
import 'package:projecto_app1/pantallas/login.dart';

class DrivePage extends StatelessWidget {
  final Chofer? driver;
  const DrivePage({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Mainap(
      driver: driver,
    ));
  }
}

class Mainap extends StatefulWidget {
  final Chofer? driver;
  const Mainap({super.key, required this.driver});

  @override
  State<Mainap> createState() => _MainapState();
}

class _MainapState extends State<Mainap> {
  int currentPageIndex = 0;
  apiHandler api = apiHandler();
  List<Tiquete>? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 61, 61, 61),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.directions_bus, color: Colors.white),
            icon: Icon(Icons.directions_bus_outlined),
            label: 'Buses',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle, color: Colors.white),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Cuenta',
          ),
        ],
      ),
      body: <Widget>[
        BusBAR(
          ced: widget.driver!.getCedula(),
        ),
        AccBAR(
            ced: widget.driver!.getCedula(),
            usern:
                "${widget.driver!.getNombre()} ${widget.driver!.getApellidos()}")
      ][currentPageIndex],
    );
  }
}

class BusBAR extends StatefulWidget {
  BusBAR({super.key, required this.ced});
  final int ced;

  @override
  State<BusBAR> createState() => _BusBARState();
}

class _BusBARState extends State<BusBAR> {
  final myController = TextEditingController();
  final apiHandler api = apiHandler();
  List<Horario>? data;
  int len = 0;

  @override
  Widget build(BuildContext context) {
    if (data?.length != null) {
      len = data!.length;
      print(data!.length);
    } else {
      len = 0;
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: SizedBox(
            width: double.maxFinite,
            height: 75,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Buses ABC",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ]),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 243, 237, 246)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)))),
                onPressed: () async {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    const Text(
                      "Ver Horarios",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 243, 237, 246)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)))),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    const Text(
                      "Dummy",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Material(
                    color: const Color.fromARGB(255, 243, 237, 246),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text("data"))),
          ],
        ),
      ),
    );
  }
}

class AccBAR extends StatefulWidget {
  AccBAR({super.key, required this.ced, required this.usern});
  final int ced;
  final String usern;

  @override
  State<AccBAR> createState() => _AccBARState();
}

class _AccBARState extends State<AccBAR> {
  final apiHandler api = apiHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: SizedBox(
            width: double.maxFinite,
            height: 75,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Buses ABC",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ]),
          )),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Image(
              image: AssetImage("res/pfp.png"),
              height: 128,
              width: 128,
            ),
            Text(widget.usern),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Perfil",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.10,
                  child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(LinearBorder.bottom(
                            side: const BorderSide(
                                color: Color.fromARGB(70, 0, 0, 0))))),
                    onPressed: () {},
                    child: const Text(
                      "Informacion personal",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.10,
                  child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(LinearBorder.bottom(
                            side: const BorderSide(
                                color: Color.fromARGB(70, 0, 0, 0))))),
                    onPressed: () {},
                    child: const Text(
                      "Editar perfil",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.10,
                  child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(LinearBorder.bottom(
                            side: const BorderSide(
                                color: Color.fromARGB(70, 0, 0, 0))))),
                    onPressed: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Cerrar Sesion'),
                                  content: const Text(
                                      'Seguro que desea cerrar sesión?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Route route = MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage());
                                        Navigator.pushAndRemoveUntil(
                                            context, route, (route) => false);
                                      },
                                      child: const Text(
                                        'Si',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text(
                                        'No',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ]));
                    },
                    child: const Text(
                      "Cerrar sesión",
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.10,
                  child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(LinearBorder.bottom(
                            side: const BorderSide(
                                color: Color.fromARGB(70, 0, 0, 0))))),
                    onPressed: () {},
                    child: const Text(
                      "Sobre nosotros",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.10,
                  child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(LinearBorder.bottom(
                            side: const BorderSide(
                                color: Color.fromARGB(70, 0, 0, 0))))),
                    onPressed: () {},
                    child: const Text(
                      "Servicio al cliente",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
