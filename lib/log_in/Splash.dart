//    @dart=2.14
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pet_service_application/log_in/screen/LogIn.dart';

class MyAppSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Splash());
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => LogIn())));

    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Container(
        child: Image.asset('images/logo.png'),
        width: 192,
        height: 192,
      ),
    );
  }
}
