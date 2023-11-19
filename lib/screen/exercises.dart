import 'package:academia/componentes/square.dart';
import 'package:flutter/material.dart';

class Exercises extends StatelessWidget {
  Exercises({super.key});

  final List _ex = [
    'ex 1',
    'ex 2',
    'ex 3',
    'ex 4',
    'ex 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _ex.length,
          itemBuilder: (context, index) {
            return MySquare(child: _ex[index]);
          }),
    );
  }
}
