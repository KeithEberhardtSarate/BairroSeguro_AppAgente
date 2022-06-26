import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

import './solicitacao.dart';

class Solicitacoes with ChangeNotifier {
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
