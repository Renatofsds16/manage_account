import 'package:flutter/material.dart';

import '../manage_firebase/manage_firebase.dart';

class InserirDados extends StatefulWidget {
  const InserirDados({super.key});

  @override
  State<InserirDados> createState() => _InserirDadosState();
}

class _InserirDadosState extends State<InserirDados> {
  ManagerFirebaseFirestore _managerFirebaseFirestore = ManagerFirebaseFirestore();
  final TextEditingController _controllerValor = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();
  final TextEditingController _controllerDetalhes = TextEditingController();
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
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite a descrição'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _controllerDetalhes,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite mais detalhes'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _controllerValor,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite o valor'),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: _salvarDados,
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
  _salvarDados(){
    _managerFirebaseFirestore.saveData();
  }
}
