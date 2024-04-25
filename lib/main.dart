import 'package:flutter/material.dart';
import 'package:projecto_app1/pantallas/login.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:window_manager/window_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  // Step 2
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const App()));
  HttpOverrides.global = MyHttpOverrides();

  var stat = await Permission.locationWhenInUse.status;

  if (stat.isDenied) {
    await Permission.locationWhenInUse.request();
  }

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
      size: Size(480, 1000),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      windowButtonVisibility: true,
      titleBarStyle: TitleBarStyle.normal);
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
  });

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
