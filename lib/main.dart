import 'package:flutter/material.dart';
import 'package:projecto_app1/pantallas/login.dart';
import 'package:flutter/services.dart';
import 'package:mssql_connection/mssql_connection.dart';
import 'dart:async';

import 'package:projecto_app1/pantallas/mainscreen.dart';

MssqlConnection sql = MssqlConnection.getInstance();
conect() async {
  try {
    bool conected = await sql.connect(
        ip: "localhost",
        port: "1433",
        databaseName: "pruebaDart",
        username: "sa",
        password: "283235118",
        timeoutInSeconds: 15);
    print("object");
  } catch (exeption) {
    return 0;
  }
}

void main() {
  // Step 2
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const App()));
  runApp(const App());
  conect();
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BusesABC",
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {"login": (_) => LoginPage(), "mainpage": (_) => MainPage()},
      initialRoute: "login",
    );
  }
}
