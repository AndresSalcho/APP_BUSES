// ignore_for_file: type_init_formals, avoid_print, must_be_immutable
import 'package:flutter/material.dart';
import 'package:projecto_app1/Usuario.dart';
import 'package:projecto_app1/apiHandler.dart';
import 'package:projecto_app1/pantallas/login.dart';

class MainPage extends StatelessWidget {
  final Usuario? user;
  const MainPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Mainap(
      user: user,
    ));
  }
}

class Mainap extends StatefulWidget {
  final Usuario? user;
  const Mainap({super.key, required this.user});

  @override
  State<Mainap> createState() => _MainapState();
}

class _MainapState extends State<Mainap> {
  int currentPageIndex = 0;
  apiHandler api = apiHandler();

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
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home_outlined),
            label: 'Principal',
          ),
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
        MainBAR(
          mon: widget.user!.getSaldo(),
          ced: widget.user!.getCedula(),
        ),
        BusBAR(
          mon: widget.user!.getSaldo(),
          ced: widget.user!.getCedula(),
        ),
        AccBAR(
            mon: widget.user!.getSaldo(),
            ced: widget.user!.getCedula(),
            usern: "${widget.user!.getNombre()} ${widget.user!.getApellidos()}")
      ][currentPageIndex],
    );
  }
}

class MainBAR extends StatefulWidget {
  MainBAR({super.key, required this.mon, required this.ced});
  double mon;
  final int ced;

  @override
  State<MainBAR> createState() => _MainBARState();
}

class _MainBARState extends State<MainBAR> {
  final myController = TextEditingController();
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
                    SizedBox(
                      width: 150,
                      height: 25,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    iconSize: 10,
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Dialog(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                        ),
                                                        Text(
                                                            "Ingrese el dinero a agregar"),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.48,
                                                          child: TextField(
                                                              controller:
                                                                  myController,
                                                              decoration: const InputDecoration(
                                                                  hintText:
                                                                      "Cantidad",
                                                                  hintStyle: TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              60,
                                                                              0,
                                                                              0,
                                                                              0)),
                                                                  focusedBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .black,
                                                                          width:
                                                                              2.0)))),
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            TextButton(
                                                                style: ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStatePropertyAll(Color.fromARGB(
                                                                            255,
                                                                            48,
                                                                            48,
                                                                            48))),
                                                                onPressed: () {
                                                                  if (!(myController
                                                                          .text ==
                                                                      "")) {
                                                                    api.updateSaldo(
                                                                        widget
                                                                            .ced,
                                                                        double.parse(
                                                                            myController.text));
                                                                  }
                                                                  Navigator.pop(
                                                                      context);
                                                                  Route route =
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const LoginPage());
                                                                  Navigator.pushAndRemoveUntil(
                                                                      context,
                                                                      route,
                                                                      (route) =>
                                                                          false);
                                                                },
                                                                child: Text(
                                                                    "Enviar",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white))),
                                                            TextButton(
                                                                style: ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStatePropertyAll(Color.fromARGB(
                                                                            255,
                                                                            48,
                                                                            48,
                                                                            48))),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    "Cancelar",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)))
                                                          ],
                                                        )
                                                      ],
                                                    )))),
                                    icon: Icon(
                                      Icons.add,
                                    )),
                                Text("Saldo: \$" + widget.mon.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ])),
                    )
                  ]),
            )),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Material(
                color: const Color.fromARGB(255, 243, 237, 246),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Mis tiquetes",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
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
                    "Comprar tiquete",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
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
        ])));
  }
}

class BusBAR extends StatefulWidget {
  BusBAR({super.key, required this.mon, required this.ced});
  double mon;
  final int ced;

  @override
  State<BusBAR> createState() => _BusBARState();
}

class _BusBARState extends State<BusBAR> {
  final myController = TextEditingController();
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
                  SizedBox(
                    width: 150,
                    height: 25,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  iconSize: 10,
                                  alignment: Alignment.center,
                                  color: Colors.white,
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) => Dialog(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                  ),
                                                  Text(
                                                      "Ingrese el dinero a agregar"),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.48,
                                                    child: TextField(
                                                        controller:
                                                            myController,
                                                        decoration: const InputDecoration(
                                                            hintText:
                                                                "Cantidad",
                                                            hintStyle: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        60,
                                                                        0,
                                                                        0,
                                                                        0)),
                                                            focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        2.0)))),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStatePropertyAll(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          48,
                                                                          48,
                                                                          48))),
                                                          onPressed: () {
                                                            if (!(myController
                                                                    .text ==
                                                                "")) {
                                                              api.updateSaldo(
                                                                  widget.ced,
                                                                  double.parse(
                                                                      myController
                                                                          .text));
                                                            }
                                                            Navigator.pop(
                                                                context);
                                                            Route route =
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const LoginPage());
                                                            Navigator
                                                                .pushAndRemoveUntil(
                                                                    context,
                                                                    route,
                                                                    (route) =>
                                                                        false);
                                                          },
                                                          child: Text("Enviar",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white))),
                                                      TextButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStatePropertyAll(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          48,
                                                                          48,
                                                                          48))),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              "Cancelar",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)))
                                                    ],
                                                  )
                                                ],
                                              )))),
                                  icon: Icon(
                                    Icons.add,
                                  )),
                              Text("Saldo: \$" + widget.mon.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ])),
                  )
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
                      "Buscar Bus",
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
                      "Ver paradas",
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
                )),
          ],
        ),
      ),
    );
  }
}

class AccBAR extends StatefulWidget {
  AccBAR(
      {super.key, required this.mon, required this.ced, required this.usern});
  double mon;
  final int ced;
  final String usern;

  @override
  State<AccBAR> createState() => _AccBARState();
}

class _AccBARState extends State<AccBAR> {
  final myController = TextEditingController();
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
                  SizedBox(
                    width: 150,
                    height: 25,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  iconSize: 10,
                                  alignment: Alignment.center,
                                  color: Colors.white,
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) => Dialog(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                  ),
                                                  Text(
                                                      "Ingrese el dinero a agregar"),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.48,
                                                    child: TextField(
                                                        controller:
                                                            myController,
                                                        decoration: const InputDecoration(
                                                            hintText:
                                                                "Cantidad",
                                                            hintStyle: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        60,
                                                                        0,
                                                                        0,
                                                                        0)),
                                                            focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        2.0)))),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStatePropertyAll(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          48,
                                                                          48,
                                                                          48))),
                                                          onPressed: () {
                                                            if (!(myController
                                                                    .text ==
                                                                "")) {
                                                              api.updateSaldo(
                                                                  widget.ced,
                                                                  double.parse(
                                                                      myController
                                                                          .text));
                                                            }
                                                            Navigator.pop(
                                                                context);
                                                            Route route =
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const LoginPage());
                                                            Navigator
                                                                .pushAndRemoveUntil(
                                                                    context,
                                                                    route,
                                                                    (route) =>
                                                                        false);
                                                          },
                                                          child: Text("Enviar",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white))),
                                                      TextButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStatePropertyAll(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          48,
                                                                          48,
                                                                          48))),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              "Cancelar",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)))
                                                    ],
                                                  )
                                                ],
                                              )))),
                                  icon: Icon(
                                    Icons.add,
                                  )),
                              Text("Saldo: \$" + widget.mon.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ])),
                  )
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
                      "Pagos",
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
