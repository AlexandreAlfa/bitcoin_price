import 'package:flutter/material.dart';
import 'package:price_bitcoin/Home.dart';
import 'dart:async';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Preço do Bitcoin',
      home: Spc(),
    );
  }
}

class Spc extends StatefulWidget {
  @override
  _SpcState createState() => _SpcState();
}

class _SpcState extends State<Spc> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('img/bitcoin.png'),
      ),
    );
  }
}
