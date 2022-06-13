import 'package:flutter/material.dart';

class Solicitacao with ChangeNotifier {
  final String tipo;
  final String idConta;

  Solicitacao({required this.tipo, required this.idConta});
}
