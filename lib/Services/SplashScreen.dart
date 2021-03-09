import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'AuthPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  Future<Timer> loadData() async {
    return new Timer(
        Duration(seconds: 10),
        onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => AuthPage(title: 'My Delivery App Auth Page'),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/acte-achat.png'),
            fit: BoxFit.cover
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color> (
              Colors.redAccent),
        ),
      ),
    );
  }
}