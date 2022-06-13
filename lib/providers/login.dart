import 'package:flutter/material.dart';

class Login with ChangeNotifier {
  final String nomeUsuario;
  final String senha;

  Login({required this.nomeUsuario, required this.senha});
}
