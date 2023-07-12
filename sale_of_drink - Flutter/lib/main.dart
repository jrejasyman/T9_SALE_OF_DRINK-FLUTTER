import 'package:flutter/material.dart';
import 'package:sale_of_drink/vista/personaVista.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter demo',
      home: personaVista(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
