import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bairroseguro_agente/providers/usuarios.dart';

import 'main_items.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Usuarios())],
      child: MaterialApp(
        title: 'BairroSeguroAgente',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // ignore: prefer_const_constructors
            Text(
              'Bairro Seguro Agente',
              style: TextStyle(fontSize: 25),
            ),
            Center(
              child: MainItems(),
            ),
          ],
        ),
      ),
    );
  }
}
