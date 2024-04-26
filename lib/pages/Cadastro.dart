import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manage_account/pages/Home.dart';

import '../manage_firebase/manage_firebase.dart';
import '../validator/validate_fields.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _controllerNomeCadastro = TextEditingController();
  TextEditingController _controllerEmailCadastro = TextEditingController();
  TextEditingController _controllerSenhaCadastro = TextEditingController();
  String? _erroNome;
  String? _erroEmail;
  String? _erroSenha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Cadastro'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: Image.asset(
                'images/dollar.png',
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(

                controller: _controllerNomeCadastro,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  errorText: _erroNome,
                    border: const OutlineInputBorder(), labelText: 'Digite seu nome'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controllerEmailCadastro,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: _erroEmail,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite seu email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _controllerSenhaCadastro,
                decoration: InputDecoration(
                  errorText: _erroSenha,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite sua senha'),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: ElevatedButton(
                          onPressed: () {
                            _validarCampos();

                          },
                          child: const Text('Cadastrar'),
                        )))
              ],
            )
          ],
        ),
      ),
    );
  }
  _validarCampos()async {
    ValidatorFields validatorNome = ValidatorFields(_controllerNomeCadastro);
    ValidatorFields validatorEmail = ValidatorFields(_controllerEmailCadastro);
    ValidatorFields validatorSenha = ValidatorFields(_controllerSenhaCadastro);
    if(validatorNome.validateField()){
      _erroNome = null;
      if(validatorEmail.validatorFieldEmail()){
        _erroEmail = null;
        if(validatorSenha.validateField()){
          _erroSenha = null;
          //cadastra usuario
          String email = _controllerEmailCadastro.text;
          String senha = _controllerSenhaCadastro.text;
          UserCredential userCredential = await _cadastraUsuario(email,senha);
          if(userCredential.user != null){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const Home()));
          }
        }else{
          setState(() {
            _erroSenha = 'O campo senha invalido digite pelo menos 6 caractere';
            print(_erroSenha);
          });
        }
      }else{
        setState(() {
          _erroEmail = 'Email invalido! Digite novamente';
          print(_erroEmail);
        });
      }
    }else{
      setState(() {
        _erroNome = 'O campo nome nao pode fica vazio';
        print(_erroNome);
      });
    }
  }
  _cadastraUsuario(String email,String senha)async {
    ManagerFirebaseAuth managerFirebaseAuth = ManagerFirebaseAuth();
    UserCredential usuario = await managerFirebaseAuth.createUserEmailAndPassword(email, senha);
    return usuario;
  }
}
