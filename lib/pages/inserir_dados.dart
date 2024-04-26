import 'package:flutter/material.dart';
import 'package:manage_account/model/contas.dart';

import '../manage_firebase/manage_firebase.dart';
import '../validator/validate_fields.dart';

class InserirDados extends StatefulWidget {
  const InserirDados({super.key});

  @override
  State<InserirDados> createState() => _InserirDadosState();
}

class _InserirDadosState extends State<InserirDados> {
  final ManagerFirebaseFirestore _managerFirebaseFirestore = ManagerFirebaseFirestore();
  final TextEditingController _controllerValor = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();
  final TextEditingController _controllerDetalhes = TextEditingController();
  String? _errorDescricao;
  String? _errorDetalhes;
  String? _errorValor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Inserir registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 32),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    'images/dollar.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),

                  child: TextField(
                    controller: _controllerDescricao,
                    decoration: InputDecoration(
                      errorText: _errorDescricao,
                        border: const OutlineInputBorder(),
                        labelText: 'Digite a descrição'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _controllerDetalhes,
                    decoration: InputDecoration(
                      errorText: _errorDetalhes,
                        border: const OutlineInputBorder(),
                        labelText: 'Digite mais detalhes'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _controllerValor,
                    decoration: InputDecoration(
                      errorText: _errorValor,
                        border: const OutlineInputBorder(),
                        labelText: 'Digite o valor'),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: _validarCampos,
                        child: const Text('Salvar'),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  _validarCampos(){
    ValidatorFields validatorFieldsDescricao = ValidatorFields(_controllerDescricao);
    ValidatorFields validatorFieldsDetalhes = ValidatorFields(_controllerDetalhes);
    ValidatorFields validatorFieldsValor = ValidatorFields(_controllerValor);
    if(validatorFieldsDescricao.validateField()){
      _errorDescricao = null;
      if(validatorFieldsDetalhes.validateField()){
        _errorDetalhes = null;
        if(validatorFieldsValor.validateFieldFloat()){
          setState(() {
            _errorValor = null;
          });
          //savar dados no firebase
          String descricao = _controllerDescricao.text;
          String detalhes = _controllerDetalhes.text;
          String valor = _controllerValor.text;
          Contas contas = Contas(descricao: descricao, detalhes: detalhes, valor: valor);
          _salvarDados(contas);

          return true;
        }else{
          setState(() {
            _errorValor = 'este campo nao pode ficar em branco';
          });
          return false;
        }
      }else{
        setState(() {
          _errorDetalhes = 'este campo nao pode ficar em branco';
        });
        return false;
      }
    }else{
      setState(() {
        _errorDescricao = 'voce precisa colocar uma descrição';
      });
      return false;
    }
  }


  _salvarDados(Contas conta){
    _managerFirebaseFirestore.saveData(conta.descricao,conta.detalhes,conta.valor);
    Navigator.pop(context);
  }
}
