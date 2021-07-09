import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_service_application/main.dart';

const Color PINK = const Color.fromRGBO(255, 113, 113, 1);
const Color GREY = const Color.fromRGBO(185, 185, 185, 1);

// enum WriteProfileState { prepare, complete } //질문2] 작성여부? {작성X, 작성O}

// class UserInfo {
//   //질문1]당신의 이름을 알고싶어요!
//   String userNickName;

//   //질문2] 함께하고 계신 친구들에 대해 이야기 가능하신가요?
//   WriteProfileState writeProfileState;

//   //질문3] 펫의 이름은? ~
//   PetInfo petInfo;

//   UserInfo(this.userNickName, this.writeProfileState, this.petInfo);
// }

// enum PetAllergy { NO, YES }
// enum PetSilhouette { BCS1, BCS2, BCS3, BCS4, BCS5 } // 반려동물 실루엣(BCS단계)

// class PetInfo {
//   final String petName; //반려동물 이름
//   final String petType; //반려동물 종류
//   final String petSpecies; //해당 반려동물 세부 종
//   PetBodyInfo petBodyInfo;
//   PetAllergy petAllergy;
//   PetSilhouette petSilhouette;

//   PetInfo(this.petName, this.petType, this.petSpecies, this.petBodyInfo,
//       this.petAllergy, this.petSilhouette);
// }

// class PetBodyInfo {
//   num petAge;
//   num petLength;
//   num petWeight;

//   PetBodyInfo(this.petAge, this.petLength, this.petWeight);
// }

// class PetAllergyType {}

class ProfileQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstRoute(),
    );
  }
}

class FirstRoute extends StatefulWidget {
  @override
  FirstRouteState createState() {
    return FirstRouteState();
  }
}

class FirstRouteState extends State<FirstRoute> {
  TextEditingController _userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 폼 위젯 생성
    // 폼 위젯은 컨테이너처럼 동작하면서, 복수의 폼 필드를 그룹화하고 적합성을 확인함
    return Scaffold(
      body: Column(
        // 컬럼내 위젯들을 가운데로 정렬함
        children: <Widget>[
          SizedBox(
            height: 196.0,
          ),
          Text.rich(
            TextSpan(children: <TextSpan>[
              TextSpan(
                  text: '당신의 이름',
                  style: TextStyle(
                      color: PINK,
                      decoration: TextDecoration.underline,
                      letterSpacing: 2.0,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '을\n알고 싶어요!',
                  style: TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2.0,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(left: 100, right: 100, top: 110),
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.black12)),
            child: Row(children: <Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _userName,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '고객님의 이름을 적어주세요!',
                        hintStyle: TextStyle(color: Colors.grey[300])),
                    cursorColor: GREY,
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 15.0),
          ButtonTheme(
            child: ElevatedButton(
              child: Text('입력 완료!'),
              style: ElevatedButton.styleFrom(
                  primary: PINK,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 117, vertical: 16),
                  textStyle: TextStyle(fontSize: 15)),
              onPressed: () {
                // 텍스트폼필드의 상태가 적함하는
                //if _formKey.currentState.validate() : 미구현
                //스낵바를 통해 메시지 출력
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));

                Navigator.push(
                    context, // 기본 파라미터, SecondRoute로 전달
                    MaterialPageRoute(
                        builder: (context) =>
                            SecondRoute())); // SecondRoute를 생성하여 적재
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 두번째 라우트
class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 131.0),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: GREY,
                size: 100.0,
              ),
              margin: EdgeInsets.fromLTRB(43, 0, 0, 0),
            ),
          ),
          SizedBox(height: 24.14),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '함께하고 계신 ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: '친구들에 대해\n',
                    style: TextStyle(
                      color: PINK,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    )),
                TextSpan(
                    text: '이야기 해 주실 수 있으신가요?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            height: 26.0,
          ),
          Text(
            '추후 마이페이지에서 다시설정 가능합니다.',
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 91.0),
          ButtonTheme(
            minWidth: 290.0,
            height: 52.0,
            child: ElevatedButton(
              child: Text('네!'),
              style: ElevatedButton.styleFrom(
                  primary: PINK,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 136, vertical: 16),
                  textStyle: TextStyle(
                    fontSize: 14,
                    //fontWeight: FontWeight.bold
                  )),
              onPressed: () {
                Navigator.push(
                    context, // 기본 파라미터, SecondRoute로 전달
                    MaterialPageRoute(
                        builder: (context) =>
                            ThirdRoute())); // SecondRoute를 생성하여 적재
              },
            ),
          ),
          SizedBox(height: 20.0),
          ButtonTheme(
            minWidth: 290.0,
            height: 52.0,
            child: OutlinedButton(
              child: Text("아니요..ㅠㅠ 바로 앱으로!"),
              style: OutlinedButton.styleFrom(
                  primary: PINK,
                  padding: EdgeInsets.symmetric(horizontal: 74, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 14,
                    //fontWeight: FontWeight.bold
                  )),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: appName)));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ThirdRoute extends StatefulWidget {
  @override
  _ThirdRouteState createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> {
  TextEditingController _petName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        SizedBox(height: 131.0),
        Row(children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: GREY,
                size: 100.0,
              ),
              margin: EdgeInsets.fromLTRB(43, 0, 0, 0),
            ),
          )
        ]),
        SizedBox(height: 24.14),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: '친구의 ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '이름은?',
                  style: TextStyle(
                    color: PINK,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          '2마리 이상일 시,\n마이페이지에서 친구를 추가할 수 있습니다.',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
        //SizedBox(height: 96.0),
        Container(
          margin: EdgeInsets.only(left: 100, right: 100, top: 96),
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 1, color: Colors.black12)),
          child: Row(children: <Widget>[
            Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _petName,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '반려동물의 이름을 적어주세요!',
                      hintStyle: TextStyle(color: Colors.grey[300])),
                  cursorColor: GREY,
                ),
              ),
            ),
          ]),
        ),
        SizedBox(height: 20.0),
        ButtonTheme(
          minWidth: 290.0,
          height: 52.0,
          child: ElevatedButton(
            child: Text("입력 완료!"),
            style: ElevatedButton.styleFrom(
                primary: PINK,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 117, vertical: 16),
                textStyle: TextStyle(
                  fontSize: 14,
                  //fontWeight: FontWeight.bold
                )),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FourthRoute()));
            },
          ),
        ),
      ]),
    );
  }
}

class FourthRoute extends StatefulWidget {
  const FourthRoute({Key? key}) : super(key: key);

  @override
  _FourthRouteState createState() => _FourthRouteState();
}

class _FourthRouteState extends State<FourthRoute> {
  // var _questions=[
  //   {
  //   "question":"어느 반려동물인가요?",
  //   "answer": ["#강아지","#고양이","#강아지","#햄스터","#기니피그","#카멜레온","#오소리","#너구리","#앵무새","#사자","#호랑이",]
  //   },
  //   {
  //     "question":"어느 종인가요?",
  //     "answer":["#강아지","#강아지","#강아지","#강아지","#강아지","#강아지","#강아지",]
  //   }
  // ];
  // var questionIndex=0;
  // void answerQuestion(){
  //   setState(() {
  //     questionIndex +=1;
  //   });
  //   print
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        SizedBox(height: 131.0),
        Row(children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: GREY,
                size: 100.0,
              ),
              margin: EdgeInsets.fromLTRB(43, 0, 0, 0),
            ),
          )
        ]),
        SizedBox(height: 24.14),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: '친구에 대해 ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '더 자세히\n',
                  style: TextStyle(
                    color: PINK,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  )),
              TextSpan(
                  text: '가르쳐 주세요!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(
          height: 34.0,
        ),
        Container(
          margin: EdgeInsets.only(left: 100, right: 100),
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 1, color: Colors.black12)),
          child: Row(children: <Widget>[
            Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: TextField(
                  //controller: _petType,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  cursorColor: GREY,
                ),
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 24.0,
        ),
        Text(
          '(반려동물 종류) 없는 항목은 직접 적어주세요!',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 47.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildHashTagButton('#강아지'),
            Padding(padding: EdgeInsets.all(20)),
            _buildHashTagButton('#고양이'),
            Padding(padding: EdgeInsets.all(20)),
            _buildHashTagButton('#햄스터'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildHashTagButton('#기니피그'),
            Padding(padding: EdgeInsets.all(20)),
            _buildHashTagButton('#카멜레온'),
            Padding(padding: EdgeInsets.all(20)),
            _buildHashTagButton('#오소리'),
            Padding(padding: EdgeInsets.all(20)),
            _buildHashTagButton('#너구리'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildHashTagButton('#앵무새'),
            Padding(padding: EdgeInsets.all(20)),
            _buildHashTagButton('#사자'),
            Padding(padding: EdgeInsets.all(20)),
            _buildHashTagButton('#호랑이'),
          ],
        ),
      ]),
    );
  }

  ElevatedButton _buildHashTagButton(String buttonText) {
    return ElevatedButton(
        child: Text(buttonText),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FourthRoute()));
        },
        style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(246, 246, 246, 1),
            onPrimary: PINK,
            padding: EdgeInsets.symmetric(horizontal: 23, vertical: 7),
            textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))));
  }
}
