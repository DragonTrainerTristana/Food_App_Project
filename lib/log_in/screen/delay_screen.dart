import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pet_service_application/log_in/class/UserData.dart';
import 'package:pet_service_application/main.dart';


class DelayScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //데이터 로딩
    UserData.getUserData(Logger().userData.uid.toString()).then((updateLogger) {
      Logger().userData = updateLogger;
      Logger().getMyPetList();
    });
    Timer(
        Duration(seconds: 7),
            () =>
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => MyHomePage())));

    return Scaffold(
      body: Column(
        //color: Colors.white,
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset('images/logo.png'),
            width: 192,
            height: 192,
          ),
          CircularProgressIndicator()
        ]
      ),
    );
  }
}
