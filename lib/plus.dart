import 'package:flutter/material.dart';
import 'package:flutter_1/main.dart';

void main() {
  runApp(const MainApp());
}

class pluspage extends StatelessWidget {
  const pluspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Contoh")),
    body: Center(
      child: Text('App1'),
      ),
    );
  }
}