import 'package:flutter/material.dart';

class Vencimentos extends StatefulWidget {
  const Vencimentos({super.key});

  @override
  State<Vencimentos> createState() => _VencimentosState();
}

class _VencimentosState extends State<Vencimentos> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text('3'),
        ),
      ),
    );
  }
}
