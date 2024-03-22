// ignore_for_file: type_init_formals, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projecto_app1/Usuario.dart';

class MainPage extends StatelessWidget {
  final Usuario? user;
  const MainPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    print(user.toString());
    return const Material(child: Mainap());
  }
}

class Mainap extends StatefulWidget {
  const Mainap({super.key});

  @override
  State<Mainap> createState() => _MainapState();
}

class _MainapState extends State<Mainap> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("user"),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Color.fromARGB(255, 61, 61, 61),
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
            )
          ],
        ));
  }
}
