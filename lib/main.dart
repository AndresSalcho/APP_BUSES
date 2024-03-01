import 'package:flutter/material.dart';
import 'package:projecto_app1/pantallas/login.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BusesABC",
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        "login": (_) => LoginPage(),
      },
      initialRoute: "login",
    );
  }
}
