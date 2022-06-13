import 'package:flutter/material.dart';

class Usuario with ChangeNotifier {
  String nome;
  String email;
  String telefone;
  String rua;
  String numero;
  String bairro;
  String cep;
  String cidade;
  String estado;
  String uf;
  String nomeUsuario;
  String senha;
  String tipo;
  String idConta;

  Usuario({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.cep,
    required this.cidade,
    required this.estado,
    required this.uf,
    required this.nomeUsuario,
    required this.senha,
    this.tipo = 'morador',
    required this.idConta,
  });
}
