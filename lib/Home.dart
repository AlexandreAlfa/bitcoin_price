import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  String _url = 'https://blockchain.info/ticker';

  @override
  _HomeState createState() => _HomeState();
}

String result;

class _HomeState extends State<Home> {
  Future<Map> _get_price() async {
    try {
      var respose = await http.get(widget._url);
      return json.decode(respose.body);
    } catch (e) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ERRO'),
              content: Text('Erro connection'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  Future _price_delay() async {
    _get_price();
    while (true) {
      await Future.delayed(Duration(seconds: 60), () {
        setState(() {
          _get_price();
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _price_delay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'img/bitcoin.png',
              width: 350,
            ),
            Padding(
                padding: EdgeInsets.all(30),
                child: Container(
                  child: FutureBuilder<Map>(
                    future: _get_price(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot snapshot,
                    ) {
                      var snc = snapshot.connectionState;
                      try {
                        if (snc == ConnectionState.waiting) {
                          result = 'carregando...';
                        } else if (snc == ConnectionState.done) {
                          result =
                              "R\$ ${snapshot.data['BRL']['buy'].toString()}";
                        }
                        return Text(result);
                      } catch (e) {
                        return Text('Erro Connection');
                      }
                    },
                  ),
                )),
            RaisedButton(
              color: Colors.orangeAccent,
              child: Text(
                'Atualizar',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  _get_price();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
