import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hhh/home.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<SplashPage> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 1), (){
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (BuildContext context) => new HomePage()
          ),
          (Route route) => route == null);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: new Color.fromARGB(255, 0, 215, 198),
      child: new Padding(
        padding: const EdgeInsets.only(top: 200),
        child: new Column(
          children: <Widget>[
            new Text(
              '豆瓣API测试',
              style: new TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}