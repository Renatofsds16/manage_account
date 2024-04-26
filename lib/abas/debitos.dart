import 'package:flutter/material.dart';

class Debitos extends StatefulWidget {
  const Debitos({super.key});

  @override
  State<Debitos> createState() => _DebitosState();
}

class _DebitosState extends State<Debitos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text('2'),
        ),
      ),
    );
  }
}
