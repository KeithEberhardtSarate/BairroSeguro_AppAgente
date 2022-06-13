import 'package:bairroseguro_agente/screens/entrar.dart';
import 'package:flutter/material.dart';

import './screens/nova_conta.dart';

class MainItems extends StatelessWidget {
  void selectPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return NovaConta();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: Entrar(),
            ),
          ],
        ));
  }
}
