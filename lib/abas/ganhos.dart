import 'package:flutter/material.dart';
import 'package:manage_account/model/contas.dart';

import '../model/contas.dart';

class Ganhos extends StatefulWidget {
  const Ganhos({super.key});

  @override
  State<Ganhos> createState() => _GanhosState();
}

class _GanhosState extends State<Ganhos> {
  final List<Contas> _listaContas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _listaContas.length,
          itemBuilder: (context,index){
          return const ListTile(
          );
          }
      )
    );
  }
}
