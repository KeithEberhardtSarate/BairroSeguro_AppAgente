import 'dart:convert';

import 'package:bairroseguro_agente/providers/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

import './usuario.dart';
import './solicitacao.dart';

class Usuarios with ChangeNotifier {
  Usuario usuarioLogado = Usuario(
      id: '',
      nome: '',
      email: '',
      telefone: '',
      rua: '',
      numero: '',
      bairro: '',
      cep: '',
      cidade: '',
      estado: '',
      uf: '',
      nomeUsuario: '',
      senha: '',
      idConta: '');

  Future<void> addUsuario(Usuario usuario) async {
    try {
      final response = await http.post(
          Uri.parse('https://bairroseguro.herokuapp.com/usuario'),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, String>{
            'nome': usuario.nome,
            'email': usuario.email,
            'telefone': usuario.telefone,
            'rua': usuario.rua,
            'numero': usuario.numero,
            'bairro': usuario.bairro,
            'cep': usuario.cep,
            'cidade': usuario.cidade,
            'estado': usuario.estado,
            'uf': usuario.uf,
            'nomeUsuario': usuario.nomeUsuario,
            'senha': usuario.senha,
            'tipo': usuario.tipo
          }));

      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<Map<dynamic, String>> autenticaUsuario(Login login) async {
    try {
      final response = await http.post(
          Uri.parse('https://bairroseguro.herokuapp.com/usuario/login'),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, String>{
            'email': login.nomeUsuario,
            'senha': login.senha,
          }));

      notifyListeners();

      final data = json.decode(response.body);

      usuarioLogado.nome = data['nome'].toString();
      usuarioLogado.idConta = data['idConta'].toString();
      usuarioLogado.id = data['_id'].toString();
      return {
        'isAutenticated': data['isAutenticated'].toString(),
        'nome': data['nome'].toString(),
        'email': data['email'].toString(),
        'telefone': data['telefone'].toString(),
        'id': data['_id'].toString(),
      };
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Usuario getUsuarioLogado() {
    return usuarioLogado;
  }

  Future<Map<dynamic, String>> addSolicitacao(Solicitacao solicitacao) async {
    try {
      final response = await http.post(
          Uri.parse('https://bairroseguro.herokuapp.com/solicitacao'),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, String>{
            'tipo': solicitacao.tipo,
            'idConta': solicitacao.idConta,
          }));

      notifyListeners();

      final data = json.decode(response.body);
      return {'_id': data['_id'].toString()};
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
