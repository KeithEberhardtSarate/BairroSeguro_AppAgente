import 'dart:math';

import 'package:bairroseguro_agente/providers/solicitacao.dart';
import 'package:bairroseguro_agente/providers/solicitacoes.dart';
import 'package:bairroseguro_agente/providers/usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/usuarios.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _isLoading = false;
  var usuarioLogado = Usuario(
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

  @override
  void didChangeDependencies() {
    var usuarioLogadoProvided =
        Provider.of<Usuarios>(context).getUsuarioLogado();

    setState(() {
      usuarioLogado = usuarioLogadoProvided;
    });
  }

  Future<void> _novaEscolta() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Usuarios>(context, listen: false).addSolicitacao(
          Solicitacao(idConta: usuarioLogado.idConta, tipo: "escolta"));
    } catch (e) {
      print(e);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Algum erro ocorreu ao ciar a solicitacao'),
          content: Text('Tente novamente'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Escolta solicitada com sucesso'),
            content: Text('Um agente está a caminho'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                child: Image.network(
                    "https://icones.pro/wp-content/uploads/2021/02/icone-utilisateur-gris.png"),
              ),
              Text(
                usuarioLogado.nome,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                color: Colors.grey[100],
                child: ListTile(
                  title: const Text("Configurações"),
                  onTap: () => print('Implementar'),
                ),
              ),
              Expanded(child: Container()),
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: Colors.black87,
                alignment: Alignment.center,
                child: const Text("Sair",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Bairro seguro Agente'),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Em desenvolvimento', style: TextStyle(fontSize: 20)),
                ],
              ),
      ),
    );
  }
}
