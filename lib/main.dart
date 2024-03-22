import 'package:flutter/material.dart';
import 'package:projecto_app1/pantallas/login.dart';
import 'package:flutter/services.dart';

void main() async {
  // Step 2
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const App()));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "BusesABC",
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          "login": (_) => const LoginPage(),
        },
        initialRoute: "login");
  }
}
