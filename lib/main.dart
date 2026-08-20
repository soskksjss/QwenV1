import 'package:flutter/material.dart';

void main() {
  runApp(const QwenApp());
}

class QwenApp extends StatelessWidget {
  const QwenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QWEN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(
          child: Text(
            'QWEN is Ready!', 
            style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
