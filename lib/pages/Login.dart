import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manage_account/manage_firebase/manage_firebase.dart';
import 'package:manage_account/pages/Home.dart';
import 'package:manage_account/validator/validate_fields.dart';
import 'Cadastro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  User? _usuarioLogado;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  String? _errorEmail;
  String? _errorPassword;

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(24),
                child: Image.asset(
                  'images/dollar.png',
                  width: 200,
                  height: 200,
                )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    errorText: _errorEmail,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite seu email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _controllerPassword,
                decoration: InputDecoration(
                    errorText: _errorPassword,
                    border: const OutlineInputBorder(),
                    labelText: 'Digite sua senha'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Não ten conta? '),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Cadastro()));
                    },
                    child: const Text(
                      'Cadastr-se',
                      style: TextStyle(color: Colors.amber),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 24,
                right: 16,
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        _validarCampos();
                      },
                      child: const Text('Login')),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  _validarCampos() async {
    ValidatorFields validatorEmail = ValidatorFields(_controllerEmail);
    ValidatorFields validatorPassword = ValidatorFields(_controllerPassword);
    if (validatorEmail.validatorFieldEmail()) {
      _errorEmail = null;
      if (validatorPassword.validateField()) {
        setState(() {
          _errorPassword = null;
        });
        //logar usuario
        UserCredential? usuario = await _logarUsuario(
            _controllerEmail.text, _controllerPassword.text);
        if (usuario != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        }
      } else {
        setState(() {
          _errorPassword = 'verifique a senha e tente novamente';
        });
      }
    } else {
      setState(() {
        _errorEmail = 'Email invalido! Digite novamente';
      });
    }
  }

  Future _logarUsuario(String email, String senha) async {
    ManagerFirebaseAuth managerFirebaseAuth = ManagerFirebaseAuth();
    UserCredential? usuario = await managerFirebaseAuth.loginUser(email, senha);
    if (usuario?.user != null) {
      return usuario;
    }
  }

  Future _verificarUsuarioLogado() async {
    ManagerFirebaseAuth managerFirebaseAuth = ManagerFirebaseAuth();
    User? usuario = await managerFirebaseAuth.checkUser();
    if (usuario != null) {
      _usuarioLogado = usuario;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
      return _usuarioLogado;
    } else {
      return _usuarioLogado;
    }
  }

  _sair() {
    ManagerFirebaseAuth managerFirebaseAuth = ManagerFirebaseAuth();
    managerFirebaseAuth.exit();
  }
}
