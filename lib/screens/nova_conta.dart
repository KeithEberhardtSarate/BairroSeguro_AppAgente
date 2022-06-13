import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/usuario.dart';
import '../providers/usuarios.dart';
import 'conta_pendente.dart';

class NovaConta extends StatefulWidget {
  @override
  _NovaContaState createState() => _NovaContaState();
}

class _NovaContaState extends State<NovaConta> {
  final _formFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedUsuario = Usuario(
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
  var _isLoading = false;

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
      await Provider.of<Usuarios>(context, listen: false)
          .addUsuario(_editedUsuario);
    } catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Algum erro ocorreu ao adicionar usuário'),
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return ContaPendente();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Conta'),
        actions: <Widget>[
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(6.0),
              child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Nome'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_formFocusNode);
                          },
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: value.toString(),
                                email: _editedUsuario.email,
                                telefone: _editedUsuario.telefone,
                                rua: _editedUsuario.rua,
                                numero: _editedUsuario.numero,
                                bairro: _editedUsuario.bairro,
                                cep: _editedUsuario.cep,
                                cidade: _editedUsuario.cidade,
                                estado: _editedUsuario.estado,
                                uf: _editedUsuario.uf,
                                nomeUsuario: _editedUsuario.nomeUsuario,
                                senha: _editedUsuario.senha,
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          textInputAction: TextInputAction.next,
                          focusNode: _formFocusNode,
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: _editedUsuario.nome,
                                email: value.toString(),
                                telefone: _editedUsuario.telefone,
                                rua: _editedUsuario.rua,
                                numero: _editedUsuario.numero,
                                bairro: _editedUsuario.bairro,
                                cep: _editedUsuario.cep,
                                cidade: _editedUsuario.cidade,
                                estado: _editedUsuario.estado,
                                uf: _editedUsuario.uf,
                                nomeUsuario: _editedUsuario.nomeUsuario,
                                senha: _editedUsuario.senha,
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Telefone'),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: _editedUsuario.nome,
                                email: _editedUsuario.email,
                                telefone: value.toString(),
                                rua: _editedUsuario.rua,
                                numero: _editedUsuario.numero,
                                bairro: _editedUsuario.bairro,
                                cep: _editedUsuario.cep,
                                cidade: _editedUsuario.cidade,
                                estado: _editedUsuario.estado,
                                uf: _editedUsuario.uf,
                                nomeUsuario: _editedUsuario.nomeUsuario,
                                senha: _editedUsuario.senha,
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Rua'),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: _editedUsuario.nome,
                                email: _editedUsuario.email,
                                telefone: _editedUsuario.telefone,
                                rua: value.toString(),
                                numero: _editedUsuario.numero,
                                bairro: _editedUsuario.bairro,
                                cep: _editedUsuario.cep,
                                cidade: _editedUsuario.cidade,
                                estado: _editedUsuario.estado,
                                uf: _editedUsuario.uf,
                                nomeUsuario: _editedUsuario.nomeUsuario,
                                senha: _editedUsuario.senha,
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Numero'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: _editedUsuario.nome,
                                email: _editedUsuario.email,
                                telefone: _editedUsuario.telefone,
                                rua: _editedUsuario.rua,
                                numero: value.toString(),
                                bairro: _editedUsuario.bairro,
                                cep: _editedUsuario.cep,
                                cidade: _editedUsuario.cidade,
                                estado: _editedUsuario.estado,
                                uf: _editedUsuario.uf,
                                nomeUsuario: _editedUsuario.nomeUsuario,
                                senha: _editedUsuario.senha,
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Bairro'),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: _editedUsuario.nome,
                                email: _editedUsuario.email,
                                telefone: _editedUsuario.telefone,
                                rua: _editedUsuario.rua,
                                numero: _editedUsuario.numero,
                                bairro: value.toString(),
                                cep: _editedUsuario.cep,
                                cidade: _editedUsuario.cidade,
                                estado: _editedUsuario.estado,
                                uf: _editedUsuario.uf,
                                nomeUsuario: _editedUsuario.nomeUsuario,
                                senha: _editedUsuario.senha,
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'CEP'),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: _editedUsuario.nome,
                                email: _editedUsuario.email,
                                telefone: _editedUsuario.telefone,
                                rua: _editedUsuario.rua,
                                numero: _editedUsuario.numero,
                                bairro: _editedUsuario.bairro,
                                cep: value.toString(),
                                cidade: _editedUsuario.cidade,
                                estado: _editedUsuario.estado,
                                uf: _editedUsuario.uf,
                                nomeUsuario: _editedUsuario.nomeUsuario,
                                senha: _editedUsuario.senha,
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Cidade'),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: _editedUsuario.nome,
                                email: _editedUsuario.email,
                                telefone: _editedUsuario.telefone,
                                rua: _editedUsuario.rua,
                                numero: _editedUsuario.numero,
                                bairro: _editedUsuario.bairro,
                                cep: _editedUsuario.cep,
                                cidade: value.toString(),
                                estado: _editedUsuario.estado,
                                uf: _editedUsuario.uf,
                                nomeUsuario: _editedUsuario.nomeUsuario,
                                senha: _editedUsuario.senha,
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Estado'),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: _editedUsuario.nome,
                                email: _editedUsuario.email,
                                telefone: _editedUsuario.telefone,
                                rua: _editedUsuario.rua,
                                numero: _editedUsuario.numero,
                                bairro: _editedUsuario.bairro,
                                cep: _editedUsuario.cep,
                                cidade: _editedUsuario.cidade,
                                estado: value.toString(),
                                uf: _editedUsuario.uf,
                                nomeUsuario: _editedUsuario.nomeUsuario,
                                senha: _editedUsuario.senha,
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'UF'),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: _editedUsuario.nome,
                                email: _editedUsuario.email,
                                telefone: _editedUsuario.telefone,
                                rua: _editedUsuario.rua,
                                numero: _editedUsuario.numero,
                                bairro: _editedUsuario.bairro,
                                cep: _editedUsuario.cep,
                                cidade: _editedUsuario.cidade,
                                estado: _editedUsuario.estado,
                                uf: value.toString(),
                                nomeUsuario: _editedUsuario.nomeUsuario,
                                senha: _editedUsuario.senha,
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Usuário'),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: _editedUsuario.nome,
                                email: _editedUsuario.email,
                                telefone: _editedUsuario.telefone,
                                rua: _editedUsuario.rua,
                                numero: _editedUsuario.numero,
                                bairro: _editedUsuario.bairro,
                                cep: _editedUsuario.cep,
                                cidade: _editedUsuario.cidade,
                                estado: _editedUsuario.estado,
                                uf: _editedUsuario.uf,
                                nomeUsuario: value.toString(),
                                senha: _editedUsuario.senha,
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Senha'),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          onSaved: (value) {
                            _editedUsuario = Usuario(
                                nome: _editedUsuario.nome,
                                email: _editedUsuario.email,
                                telefone: _editedUsuario.telefone,
                                rua: _editedUsuario.rua,
                                numero: _editedUsuario.numero,
                                bairro: _editedUsuario.bairro,
                                cep: _editedUsuario.cep,
                                cidade: _editedUsuario.cidade,
                                estado: _editedUsuario.estado,
                                uf: _editedUsuario.uf,
                                nomeUsuario: _editedUsuario.nomeUsuario,
                                senha: value.toString(),
                                idConta: _editedUsuario.idConta);
                          },
                        ),
                        RaisedButton(
                          child: Text('Criar conta'),
                          onPressed: () => _saveForm(),
                        ),
                      ],
                    ),
                  )),
            ),
    );
  }
}
