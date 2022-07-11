import 'dart:async';
import 'dart:math';

import 'package:bairroseguro_agente/notification_service.dart';
import 'package:bairroseguro_agente/providers/solicitacao.dart';
import 'package:bairroseguro_agente/providers/solicitacoes.dart';
import 'package:bairroseguro_agente/providers/usuario.dart';
import 'package:bairroseguro_agente/screens/map.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/usuarios.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic _solicitacao = {
    '_id': '',
    'idAgente': '',
    'tipo': '',
    'idConta': '',
    'status': '',
    'lat': '',
    'lon': '',
  };
  late DatabaseReference _solicitacoesRef;
  late StreamSubscription<DatabaseEvent> _solicitacoesAddedSubscription;
  late StreamSubscription<DatabaseEvent> _solicitacoesChangedSubscription;

  var _isLoading = false;
  var usuarioLogado = Usuario(
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

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _solicitacoesRef = FirebaseDatabase.instance.ref('solicitacoes');
    // TO DO testar se o agente já está com escolta em andamento, se sim, preencher a solicitação com a escolta em andamento

    // try {
    //   final solicitacoesSnapshot =
    //       await _solicitacoesRef.child(usuarioLogado.idConta).get();

    //   if (solicitacoesSnapshot.exists) {
    //     _solicitacao = solicitacoesSnapshot.value as dynamic;
    //   }
    // } catch (err) {
    //   debugPrint(err.toString());
    // }

    _solicitacoesAddedSubscription =
        _solicitacoesRef.onChildAdded.listen((DatabaseEvent event) {
      setState(() {
        if (event.snapshot.value != null &&
            (event.snapshot.value as Map)['status'] == 'solicitada') {
          // TO DO testar se o agente já está com escolta em andamento
          _solicitacao['_id'] = (event.snapshot.value as Map)['_id'];
          _solicitacao['idAgente'] = (event.snapshot.value as Map)['idAgente'];
          _solicitacao['tipo'] = (event.snapshot.value as Map)['tipo'];
          _solicitacao['idConta'] = (event.snapshot.value as Map)['idConta'];
          _solicitacao['status'] = (event.snapshot.value as Map)['status'];
          _solicitacao['lat'] = (event.snapshot.value as Map)['lat'];
          _solicitacao['lon'] = (event.snapshot.value as Map)['lon'];

          print(_solicitacao);

          Provider.of<NotificationService>(context, listen: false)
              .showNotification(CustomNotification(
                  id: 1,
                  title: 'Nova solicitação',
                  body: 'escolta',
                  payload: '/default'));
        }
      });
    });

    _solicitacoesChangedSubscription =
        _solicitacoesRef.onChildChanged.listen((DatabaseEvent event) {
      setState(() {
        if (event.snapshot.value != null &&
            (event.snapshot.value as Map)['status'] == 'solicitada') {
          // TO DO testar se o agente já está com escolta em andamento
          _solicitacao['_id'] = (event.snapshot.value as Map)['_id'];
          _solicitacao['idAgente'] = (event.snapshot.value as Map)['idAgente'];
          _solicitacao['tipo'] = (event.snapshot.value as Map)['tipo'];
          _solicitacao['idConta'] = (event.snapshot.value as Map)['idConta'];
          _solicitacao['status'] = (event.snapshot.value as Map)['status'];
          _solicitacao['lat'] = (event.snapshot.value as Map)['lat'];
          _solicitacao['lon'] = (event.snapshot.value as Map)['lon'];

          print(_solicitacao);

          Provider.of<NotificationService>(context, listen: false)
              .showNotification(CustomNotification(
                  id: 1,
                  title: 'Nova solicitação',
                  body: 'escolta',
                  payload: '/default'));
        }
      });
    });
  }

  void dispose() {
    _solicitacoesAddedSubscription.cancel();
    _solicitacoesChangedSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    var usuarioLogadoProvided =
        Provider.of<Usuarios>(context).getUsuarioLogado();

    setState(() {
      usuarioLogado = usuarioLogadoProvided;
    });
  }

  _aceitaSolicitacao() async {
    _solicitacoesRef = FirebaseDatabase.instance
        .ref('solicitacoes/${_solicitacao['idConta']}');

    await _solicitacoesRef
        .update({"status": "aceita", "idAgente": usuarioLogado.id});

    setState(() {
      _solicitacao['status'] = 'aceita';
      _solicitacao['idAgente'] = usuarioLogado.id;
    });
  }

  _recusarSolicitacao() {
    print('Implementar');
  }

  _finalizarSolicitacao() async {
    _solicitacoesRef = FirebaseDatabase.instance
        .ref('solicitacoes/${_solicitacao['idConta']}');

    await _solicitacoesRef.update({"status": "finalizada"});

    _clearSolicitacao();
  }

  _clearSolicitacao() {
    setState(() {
      _solicitacao['_id'] = '';
      _solicitacao['idAgente'] = '';
      _solicitacao['tipo'] = '';
      _solicitacao['idConta'] = '';
      _solicitacao['status'] = '';
    });
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
        body: Stack(children: <Widget>[
          new Container(
            height: 1000, // This line solved the issue
            child: MapScreen(), // Mapbox
          ),
          Container(
            width: double.infinity,
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(child: Container()),
                      Container(
                        child: _solicitacao != null &&
                                _solicitacao['_id'] != '' &&
                                _solicitacao['status'] == 'solicitada'
                            ? Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(25),
                                child: Column(
                                  children: <Widget>[
                                    const Text('Nova solicitação de escolta',
                                        style: TextStyle(fontSize: 20)),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 40, right: 40),
                                      width: double.infinity,
                                      color: Colors.black87,
                                      alignment: Alignment.center,
                                      child: ListTile(
                                        title: const Center(
                                          child: Text("Aceitar",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        onTap: () => _aceitaSolicitacao(),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 15, left: 40, right: 40),
                                      width: double.infinity,
                                      color: Colors.black87,
                                      alignment: Alignment.center,
                                      child: ListTile(
                                        title: const Center(
                                          child: Text("Recusar",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        onTap: () => _recusarSolicitacao(),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const Text(''),
                      ),
                      Column(children: [
                        if (_solicitacao != null &&
                            _solicitacao['status'] == 'aceita') ...[
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: double.infinity,
                            color: Colors.black87,
                            alignment: Alignment.center,
                            child: ListTile(
                              title: Center(
                                  child: Column(
                                children: [
                                  if (_solicitacao != null &&
                                      _solicitacao['status'] == 'aceita') ...[
                                    const Text("Finalizar",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))
                                  ]
                                ],
                              )),
                              onTap: () => _finalizarSolicitacao(),
                            ),
                          ),
                        ]
                      ]),
                    ],
                  ),
          ),
        ]));
  }
}
