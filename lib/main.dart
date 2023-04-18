import 'package:ar_testing/localobjectdisplay.dart';
import 'package:ar_testing/screens/ModelsListScreen.dart';
import 'package:ar_testing/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'ar_panorama.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Viewer',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          // ignore: deprecated_member_use
          accentColor: Colors.black87,
          canvasColor: Colors.white,
          cardColor: Colors.amber,
          shadowColor: Colors.black87,
          textTheme: const TextTheme(
              bodyText1: TextStyle(
                  color: Colors.black87, fontSize: 16, fontFamily: 'Raleway'),
              bodyText2: TextStyle(
                  color: Colors.black87, fontSize: 14, fontFamily: 'Raleway'),
              headline6: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
              )).apply(bodyColor: Colors.black87)),
      darkTheme: ThemeData(
          primarySwatch: Colors.amber,
          // ignore: deprecated_member_use
          accentColor: Colors.black87,
          canvasColor: Color.fromRGBO(40, 40, 40, 0.85),
          cardColor: Colors.amber,
          shadowColor: Colors.amber,
          textTheme: const TextTheme(
              bodyText1: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Raleway'),
              bodyText2: TextStyle(
                  color: Colors.black87, fontSize: 14, fontFamily: 'Raleway'),
              headline6: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
              ))),
      routes: {
        TabsScreen.routhPath: (context) => const TabsScreen(),
        ModelsListScreen.routePath: (context) => ModelsListScreen(),
        LocalObjectWidget.routePath: (context) => const LocalObjectWidget(),
        ARPanorama.routePath: (context) => const ARPanorama(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
