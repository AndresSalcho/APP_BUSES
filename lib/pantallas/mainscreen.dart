// ignore_for_file: type_init_formals, avoid_print, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:osrm/osrm.dart';
import 'package:projecto_app1/Asiento.dart';
import 'package:projecto_app1/Horario.dart';
import 'package:projecto_app1/Location.dart';
import 'package:projecto_app1/Tiquete.dart';
import 'package:projecto_app1/Usuario.dart';
import 'package:projecto_app1/apiHandler.dart';
import 'package:projecto_app1/pantallas/login.dart';
import 'package:projecto_app1/routeMap.dart';
import 'package:latlong2/latlong.dart';

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
          vip: widget.user!.getDiscapacitado(),
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
  MainBAR({super.key, required this.mon, required this.ced, required this.vip});
  double mon;
  final bool vip;
  final int ced;

  @override
  State<MainBAR> createState() => _MainBARState();
}

class _MainBARState extends State<MainBAR> {
  final myController = TextEditingController();
  final apiHandler api = apiHandler();
  List<Horario>? dataH;
  List<Asiento>? dataA;
  int? actual = null;
  int len = 0;
  late Future<List<Tiquete>> _data;

  @override
  void initState() {
    super.initState();
    _data = api.getTiquete(widget.ced);
  }

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
                      width: 200,
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
        body: FutureBuilder(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                len = 0;
              } else {
                len = snapshot.data!.length;
              }
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Expanded(
                            child: Container(
                          color: const Color.fromARGB(255, 243, 237, 246),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Mis tiquetes",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: Material(
                                    color: const Color.fromARGB(
                                        255, 243, 237, 246),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListView.separated(
                                        padding: const EdgeInsets.all(8),
                                        itemCount: len,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (snapshot.data != null) {
                                            return TextButton(
                                                style: ButtonStyle(
                                                    side:
                                                        MaterialStatePropertyAll(
                                                            BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    shape: MaterialStatePropertyAll(
                                                        LinearBorder(
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .black)))),
                                                onPressed: () async {
                                                  Route route = MaterialPageRoute(
                                                      builder: (context) => MapBar(
                                                          busSerie: snapshot
                                                              .data![index]
                                                              .getSerieBus()));
                                                  Navigator.push(
                                                      context, route);
                                                },
                                                child: Text(
                                                  "Tiquete n° " +
                                                      snapshot
                                                          .data![index].idPago
                                                          .toString() +
                                                      "\nDescripcion: " +
                                                      snapshot.data![index]
                                                          .descripcipon +
                                                      "\nRuta - " +
                                                      snapshot.data![index]
                                                          .getLugarS() +
                                                      " - " +
                                                      snapshot.data![index]
                                                          .getLugarLL() +
                                                      "\nCosto: " +
                                                      snapshot
                                                          .data![index].costo
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                ));
                                          } else {
                                            return null;
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider()),
                                  ))
                            ],
                          ),
                        ))),
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
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                        onPressed: () async {
                          dataH = await api.getHorario();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Seleccione la ruta en la que desea viajar\n",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Material(
                                          color: const Color.fromARGB(
                                              255, 243, 237, 246),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: ListView.separated(
                                              padding: const EdgeInsets.all(8),
                                              itemCount: dataH!.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                if (dataH != null) {
                                                  return TextButton(
                                                      style: ButtonStyle(
                                                          side: MaterialStatePropertyAll(
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                          shape: MaterialStatePropertyAll(
                                                              LinearBorder(
                                                                  side: BorderSide(
                                                                      color: Colors
                                                                          .black)))),
                                                      onPressed: () async {
                                                        dataA = await api.getAsiento(
                                                            dataH![index]
                                                                .getIdParada(),
                                                            dataH![index]
                                                                .getIdHorario());
                                                        actual = dataH![index]
                                                            .getIdParada();

                                                        Navigator.pop(context);
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Center(
                                                                  child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Seleccione el asiento a tomar\n",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                  SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.40,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.85,
                                                                      child:
                                                                          Material(
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            243,
                                                                            237,
                                                                            246),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15)),
                                                                        child: ListView.separated(
                                                                            padding: const EdgeInsets.all(8),
                                                                            itemCount: dataA!.length,
                                                                            shrinkWrap: true,
                                                                            scrollDirection: Axis.vertical,
                                                                            itemBuilder: (BuildContext context, int index) {
                                                                              if (dataH != null) {
                                                                                if (widget.vip && dataA![index].exclusive) {
                                                                                  return TextButton(
                                                                                      style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: Colors.black)), shape: MaterialStatePropertyAll(LinearBorder(side: BorderSide(color: Colors.black)))),
                                                                                      onPressed: () async {
                                                                                        await api.compraTiquete(widget.ced, dataA![index].getIdAsiento(), actual!, dataA![index].getIdHorario());
                                                                                        Navigator.pop(context);
                                                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget));
                                                                                      },
                                                                                      child: Text(
                                                                                        "Asiento " + dataA![index].getIdAsiento().toString() + "\nOcupado: " + dataA![index].getOcupado().toString() + "\nExclusivo: " + dataA![index].getExclusivo().toString(),
                                                                                        style: TextStyle(color: Colors.black),
                                                                                        textAlign: TextAlign.center,
                                                                                      ));
                                                                                } else if (!widget.vip && !dataA![index].exclusive) {
                                                                                  if (dataA![index].ocupado) {
                                                                                    return TextButton(
                                                                                        style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: Colors.black)), shape: MaterialStatePropertyAll(LinearBorder(side: BorderSide(color: Colors.black)))),
                                                                                        onPressed: () {},
                                                                                        child: Text(
                                                                                          "Asiento " + dataA![index].getIdAsiento().toString() + "\nOcupado: " + dataA![index].getOcupado().toString() + "\nExclusivo: " + dataA![index].getExclusivo().toString(),
                                                                                          style: TextStyle(color: Colors.red),
                                                                                          textAlign: TextAlign.center,
                                                                                        ));
                                                                                  } else {
                                                                                    return TextButton(
                                                                                        style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: Colors.black)), shape: MaterialStatePropertyAll(LinearBorder(side: BorderSide(color: Colors.black)))),
                                                                                        onPressed: () async {
                                                                                          await api.compraTiquete(widget.ced, dataA![index].getIdAsiento(), actual!, dataA![index].getIdHorario());
                                                                                          Navigator.pop(context);
                                                                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget));
                                                                                        },
                                                                                        child: Text(
                                                                                          "Asiento " + dataA![index].getIdAsiento().toString() + "\nOcupado: " + dataA![index].getOcupado().toString() + "\nExclusivo: " + dataA![index].getExclusivo().toString(),
                                                                                          style: TextStyle(color: Colors.black),
                                                                                          textAlign: TextAlign.center,
                                                                                        ));
                                                                                  }
                                                                                }
                                                                                return null;
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                            separatorBuilder: (BuildContext context, int index) => const Divider()),
                                                                      ))
                                                                ],
                                                              ));
                                                            });
                                                      },
                                                      child: Text(
                                                        "Bus: " +
                                                            dataH![index]
                                                                .gatBusSerie() +
                                                            "\nHora: " +
                                                            dataH![index]
                                                                .getHora() +
                                                            "\nParada: " +
                                                            dataH![index]
                                                                .getParada() +
                                                            "\nCosto: " +
                                                            dataH![index]
                                                                .getCostoParada()
                                                                .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ));
                                                } else {
                                                  return null;
                                                }
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      const Divider()),
                                        ))
                                  ],
                                ));
                              });
                        },
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
                              "Comprar Tiquete",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
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
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
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
                              "Dummy",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]));
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            }
          },
        ));
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
                  SizedBox(
                    width: 200,
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
                onPressed: () async {
                  data = await api.getHorario();
                  setState(() {});
                },
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
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: len,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      if (data != null) {
                        return Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(14, 0, 0, 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text("Hora " +
                                data![index].getHora() +
                                "\nParada: " +
                                data![index].getParada() +
                                "\nCosto: " +
                                data![index].getCostoParada().toString() +
                                "\nSerie: " +
                                data![index].gatBusSerie() +
                                "\n"));
                      } else {
                        return null;
                      }
                    },
                  ),
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
                    width: 200,
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

class MapBar extends StatefulWidget {
  const MapBar({super.key, required this.busSerie});
  final String busSerie;

  @override
  State<MapBar> createState() => _MapBarState();
}

class _MapBarState extends State<MapBar> {
  final apiHandler api = apiHandler();
  final Routemap route = Routemap();
  late LatLng? destino;
  late LatLng? bus;
  LatLng? myPos;
  late Future<bool?> state;
  late MapController _mapController;
  late List<LatLng>? puntos;
  Osrm osrm = Osrm();
  bool start = false;
  String? text;
  IconData? ico;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  Future<bool> getLocs(String busS) async {
    Location? aux;
    aux = await api.getLocationParada(busS);
    destino = new LatLng(aux!.latitud, aux.longitud);

    aux = await api.getLocation(busS);
    bus = new LatLng(aux!.latitud, aux.longitud);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: SizedBox(
              width: double.maxFinite,
              height: 75,
            )),
        body: StreamBuilder<Position>(
            stream: Geolocator.getPositionStream(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                myPos =
                    LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
                return FutureBuilder(
                    future: getLocs(widget.busSerie),
                    builder: ((context, sanp) {
                      if (sanp.hasData) {
                        return FutureBuilder(
                            future: route.getRuta(bus!.latitude, bus!.longitude,
                                destino!.latitude, destino!.longitude),
                            builder: (((context, snapshot2) {
                              if (snapshot2.hasData) {
                                puntos = snapshot2.data;
                                return Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.80,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: Material(
                                              color: const Color.fromARGB(
                                                  255, 243, 237, 246),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: FlutterMap(
                                                  mapController: _mapController,
                                                  options: MapOptions(
                                                      initialCenter: myPos!,
                                                      initialZoom: 16,
                                                      maxZoom: 20,
                                                      minZoom: 15),
                                                  children: [
                                                    TileLayer(
                                                      urlTemplate:
                                                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                      userAgentPackageName:
                                                          'com.example.app',
                                                    ),
                                                    PolylineLayer(polylines: [
                                                      Polyline(
                                                          points: puntos!,
                                                          color: Colors.black,
                                                          strokeWidth: 6)
                                                    ]),
                                                    MarkerLayer(markers: [
                                                      Marker(
                                                        point:
                                                            myPos!, // Use the new position
                                                        width: 80,
                                                        height: 80,
                                                        child: Icon(
                                                            Icons.person_pin,
                                                            color: Colors.red),
                                                      ),
                                                      Marker(
                                                        point:
                                                            bus!, // Use the new position
                                                        width: 80,
                                                        height: 80,
                                                        child: Icon(
                                                            Icons
                                                                .directions_bus,
                                                            color: Colors.red),
                                                      ),
                                                      Marker(
                                                        point:
                                                            destino!, // Use the new position
                                                        width: 80,
                                                        height: 80,
                                                        child: Icon(
                                                            Icons.location_on,
                                                            color: Colors.red),
                                                      ),
                                                      // Add other markers if needed
                                                    ]),
                                                  ]))),
                                    ],
                                  ),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.black,
                                ));
                              }
                            })));
                      } else {
                        return Center(
                          child: Text("El bus no se encuentra activo ahora"),
                        );
                      }
                    }));
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ));
              }
            })));
  }
}
