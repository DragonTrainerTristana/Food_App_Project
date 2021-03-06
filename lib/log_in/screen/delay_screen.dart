import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pet_service_application/log_in/class/UserData.dart';
import 'package:pet_service_application/main.dart';

class DelayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 800;

    //데이터 로딩
    UserData.getUserData(Logger().userData.uid.toString()).then((updateLogger) {
      Logger().userData = updateLogger;
      Logger().getMyPetList();
    });
    Timer(
        Duration(seconds: 5), // 7초는 너무 길어서, 5초로 수정
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage())));

    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        SizedBox(height: height * 300),
        Container(
          alignment: Alignment.center,
          child: Column(children: [
            Image.asset('images/logo.png', width: 192, height: 192),
            CircularProgressIndicator()
          ]),
        ),
      ]),
    );
  }
}
