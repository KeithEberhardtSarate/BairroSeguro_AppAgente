import 'package:bairroseguro_agente/main.dart';
import 'package:bairroseguro_agente/screens/home.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/home': (_) => MyHomePage(),
    '/default': (_) => Home(),
  };

  static String initial = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
