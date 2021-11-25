import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_service_application/log_in/class/UserData.dart';
import 'package:pet_service_application/appbar/AppBarWithAlarm.dart';
import 'package:pet_service_application/bottombar/MenuBottomBar.dart';

class MyCommunityScreen extends StatefulWidget {
  const MyCommunityScreen({Key? key}) : super(key: key);
  @override
  _MyCommunityScreenState createState() => _MyCommunityScreenState();
}

class _MyCommunityScreenState extends State<MyCommunityScreen> {
  UserData myInfo = Logger().userData;

  //initState()

  @override
  Widget build(BuildContext context) {
    const double nameSize = 20;
    const double textSize = 16;

    return Scaffold(
      body: ListView(
        children : [
          AppBarWithAlarm(nickName: myInfo.Name), //닉네임 & 알림
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children : [
              Image.asset(
                'images/loginIcon/icon_kakao.png',
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.2,
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.2,
              ),  //프로필 아이콘
              Text(
                myInfo.Name,
                style: TextStyle(
                  fontSize: nameSize,
                  fontWeight: FontWeight.bold
                ),

              ),
              Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(16.0),
                  color: Colors.grey
                ),
                child: Text(
                  '팔로잉 '+myInfo.following.toString()+' · 팔로워 '+myInfo.follower.toString(),
                  style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ]
          ),  //프로필 정보
          Row(

          ),  //글&쇼츠 올리기 버튼
          Column(

          ) //내 게시글 뷰
        ],
      ),
      floatingActionButton: BackSpaceButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}