import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  final child;
  const MySquare({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 200,
          color: Color.fromRGBO(250, 162, 0, 1),
          child: Center(
            child: Text(
              child,
              style: TextStyle(fontSize: 50),
            ),
          ),
        ),
      ),
    );
  }
}
