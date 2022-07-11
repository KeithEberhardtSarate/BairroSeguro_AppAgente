import 'package:bairroseguro_agente/notification_service.dart';
import 'package:bairroseguro_agente/routes.dart';
import 'package:bairroseguro_agente/screens/entrar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:bairroseguro_agente/providers/usuarios.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
            create: (context) => NotificationService())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Usuarios()),
      ],
      child: MaterialApp(
        title: 'BairroSeguro',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        routes: Routes.list,
        initialRoute: Routes.initial,
        navigatorKey: Routes.navigatorKey,
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
    return Scaffold(body: Entrar());
  }
}
