
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALRC Radio Business',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('ALRC Radio Business'),
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: Text(
            'Bienvenue sur la Radio Business !',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
