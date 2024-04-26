import 'package:flutter/material.dart';
import 'package:manage_account/abas/Vencimentos.dart';
import 'package:manage_account/abas/debitos.dart';
import 'package:manage_account/pages/inserir_dados.dart';

import '../abas/ganhos.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Sua atividade finaceira'),
        actions: const [
          Padding(padding: EdgeInsets.only(right: 16), child: Icon(Icons.close))
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Ganhos',
              icon: Icon(Icons.monetization_on),
            ),
            Tab(text: 'Debito', icon: Icon(Icons.device_thermostat_rounded)),
            Tab(text: 'Vencimento', icon: Icon(Icons.date_range)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Ganhos(),
          Debitos(),
          Vencimentos(),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: FloatingActionButton(
          shape: const StadiumBorder(),
          onPressed: _newDisplaY,
          child: const Text('+',
              style: TextStyle(fontSize: 40, color: Colors.black38)),
        ),
      ),
    );
  }
  _newDisplaY(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const InserirDados()));
  }


}
