import 'package:bairroseguro_agente/providers/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/usuarios.dart';
import 'conta_pendente.dart';
import 'home.dart';

import '../screens/nova_conta.dart';

class Entrar extends StatefulWidget {
  @override
  _EntrarState createState() => _EntrarState();
}

class _EntrarState extends State<Entrar> {
  final _formFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedLogin = Login(nomeUsuario: '', senha: '');
  var _isLoading = false;

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
  void dispose() {
    _formFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await Provider.of<Usuarios>(context, listen: false)
          .autenticaUsuario(_editedLogin);
      if (data['isAutenticated'] == 'true') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return Home();
            },
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Usuário ou senha inválidos'),
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
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Usuário ou senha inválidos'),
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
      });
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (_) {
      //       return ContaPendente();
      //     },
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(6.0),
              child: Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_formFocusNode);
                        },
                        onSaved: (value) {
                          _editedLogin = Login(
                              nomeUsuario: value.toString(),
                              senha: _editedLogin.senha);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Senha'),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _editedLogin = Login(
                              nomeUsuario: _editedLogin.nomeUsuario,
                              senha: value.toString());
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        width: double.infinity,
                        color: Colors.black87,
                        alignment: Alignment.center,
                        child: ListTile(
                          title: Center(
                            child: const Text("Entrar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          onTap: () => _saveForm(),
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }
}
