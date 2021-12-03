import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pet_service_application/class/colorCustomClass.dart';
import 'package:pet_service_application/init_profile/widget/HashTagWidget.dart';
import 'package:pet_service_application/log_in/class/UserData.dart';
import 'package:pet_service_application/init_profile/widget/AlertDuplicateMessage.dart';
import 'package:pet_service_application/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirstRoute();
  }
}


class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  FirstRouteState createState() {
    return FirstRouteState();
  }
}
//이름 입력 및 계정 생성
class FirstRouteState extends State<FirstRoute> {
  TextEditingController userNickname = TextEditingController();

  //유저 정보
  UserData myData = Logger().userData;

  // 닉네임 중복 여부 컨테이너 bool 값
  bool _offstage = true;

  //파이어베이스 스테이트
  bool _initialized = false;
  bool _error = false;

  //파이어베이스 이니셜
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 360.0;
    var height = MediaQuery.of(context).size.height / 800.0;
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드가 올라오면서 화면을 밀어내지 않는 것
      body: SafeArea(
        child: SingleChildScrollView(
          child: WillPopScope(
            onWillPop: () {
              // _msg : 뒤로가기 버튼 누를 시 메시지
              final _msg = '프로필 작성을 마무리 해주세요 !';
              final snackBar = SnackBar(content: Text(_msg));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              // 필수 인자
              return Future(() => false);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width * 30),
              child: Column(
                // 컬럼내 위젯들을 가운데로 정렬함
                children: [
                  SizedBox(height: height * 200),
                  //text box: 당신의 이름을\n알고 싶어요!
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: customTitleQuestion('', '당신의 이름', '을\n알고 싶어요!'),
                  ),
                  SizedBox(height: height * 110),
                  // 사용자 이름 입력 박스
                  Column(children: [
                    //감춰진 컨테이너 : "이미 사용중인 이름입니다."
                    Offstage(
                        offstage: _offstage, child: AlertDuplicateMessage()),
                    SizedBox(height: height * 15.0),

                    customTextFormField(
                        userNickname, '사용자의 이름을 입력해주세요! (2-8자 이내)'),
                    SizedBox(height: height * 25.0),

                    customPinkElevatedButton('입력 완료!', () {
                      Future<bool> userExist = Logger().isUserExist(userNickname.text);
                      userExist.then((val) {
                        if (val == true) {
                          setState(() {
                            // 닉네임 중복 bool 값을 true->false로 변경
                            _offstage = false;
                          });
                          //닉네임 중복(유저 이미 존재)
                          debugPrint('User Already Exist : $userNickname.text');
                        } else {
                          // 닉네임 중복 bool 값을 false-> true로 변경
                          setState(() {
                            _offstage = true;
                          });
                          //유저 정보 없음, 계정 생성 후 다음으로 이동
                          debugPrint('User doesnt Exist, initiate user');
                          Logger().userData.name = userNickname.text;
                          Logger().sendUserData();
                          debugPrint(
                              'User ID : ' + Logger().userData.uid.toString());
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: SecondRoute(),
                                  type: PageTransitionType.rightToLeft));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //             builder: (context) => SecondRoute()));
                        }
                      });
                    }),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}
//펫 데이터 추가 입력 여부 선택
class _SecondRouteState extends State<SecondRoute> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 360.0;
    var height = MediaQuery.of(context).size.height / 800.0;

    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          // <- 뒤로가기 기능 방지 (이미 계정을 생성했기 때문)
          onWillPop: () {
            // _msg : 뒤로가기 버튼 누를 시 메시지
            final _msg = '프로필 작성을 마무리 해주세요!';
            final snackBar = SnackBar(content: Text(_msg));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // 필수 인자
            return Future(() => false);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 30),
            child: Column(
              children: [
                // 알림바: 계정 생성 완료!
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 180,
                          height: 30,
                          color: Color.fromRGBO(166, 0, 0, 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "계정 생성 완료!  ✔",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(242, 128, 128, 1)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 155),
                // 문구2-1: 함께하고 계신 ~
                Container(
                  alignment: Alignment.centerLeft,
                  child: customTitleQuestion(
                      "함께하고 계신 ", "친구들에 대해\n", "이야기 해 주실 수 있으신가요?"),
                ),
                SizedBox(height: height * 30.0),
                // 문구2-2: 추후 마이페이지에서~
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text("추후 마이페이지에서 다시 설정 가능합니다.",
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold))),
                SizedBox(height: height * 75.0),
                //버튼 : 네!
                Container(
                  child: customPinkElevatedButton('네!', () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: ThirdRoute(),
                            type: PageTransitionType.rightToLeft));
                  }),
                ),
                SizedBox(height: height * 25.0),
                // 버튼: 아니요.. ㅠㅠ 바로 앱으로!
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 50.0),
                  child: customPinkElevatedButton('아니요.. ㅠㅠ  바로 앱으로 !', () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                        (route) => false);
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ThirdRoute extends StatefulWidget {
  @override
  _ThirdRouteState createState() => _ThirdRouteState();
}
//펫 생성 시작 및 펫 이름 입력 페이지
class _ThirdRouteState extends State<ThirdRoute> {
  TextEditingController _petName = TextEditingController();

  @override
  void initState() {
    //펫정보 입력을 위한 데이터 수신
    PetInfo.initialPetListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 360;
    var height = MediaQuery.of(context).size.height / 800;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 30),
            child: Column(children: [
              SizedBox(height: height * 100),
              // 뒤로가기 버튼
              Container(
                //margin: EdgeInsets.only(left: 25.0, top: 110.0),
                child: customArrowBack(context),
              ),
              SizedBox(height: height * 25),

              Container(
                alignment: Alignment.centerLeft,
                child: customTitleQuestion("친구의 ", "이름은?", ""),
              ),
              SizedBox(height: height * 20),
              Container(
                alignment: Alignment.centerLeft,
                child: customSubtitleQuestion(
                    "2마리 이상일 시,\n마이페이지에서 친구를 추가할 수 있습니다."),
              ),
              SizedBox(height: height * 90),
              customTextFormField(_petName, '반려동물의 이름을 입력해주세요! ( 8자 이내 )'),

              SizedBox(height: 20.0),
              customPinkElevatedButton("입력 완료!", () {
                //펫 이름으로 새 데이터 생성 후 현재 앱 유저에 삽입
                PetInfo createPet = PetInfo(_petName.text);
                // 화면 전환 애니메이션 효과
                Navigator.push(
                    context,
                    PageTransition(
                        child: FourthRoute(newPet: createPet),
                        type: PageTransitionType.rightToLeft));
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => FourthRoute()));
              })
            ]),
          ),
        ),
      ),
    );
  }
}

class FourthRoute extends StatefulWidget {
  final PetInfo newPet;
  const FourthRoute({Key? key, required this.newPet}) : super(key: key);

  @override
  _FourthRouteState createState() => _FourthRouteState();
}
// 4번째 라우터 - 펫 타입 입력
class _FourthRouteState extends State<FourthRoute> {

  // 1 : 첫번째 카테고리, 2: 두번째 카테고리, 3: 다음 라우터 이동용 인덱스
  int currentState = 1;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 360;
    var height = MediaQuery.of(context).size.height / 800;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: height * 130),
            //SizedBox(height: height*93),
            Container(
                margin: EdgeInsets.symmetric(horizontal: width * 30),
                alignment: Alignment.centerLeft,
                child: customArrowBack(context)),
            //Container(alignment:Alignment.centerLeft ,child: customArrowBack(context)),
            SizedBox(height: height * 30),
            Container(
                margin: EdgeInsets.symmetric(horizontal: width * 40),
                alignment: Alignment.centerLeft,
                child: customTitleQuestion("친구에 대해 ", "더 자세히\n", "가르쳐 주세요!")),
            SizedBox(height: height * 35),
            // 카드
            Container(
              width: width * 300,
              height: 70,
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(children: [
                      Offstage(
                          offstage: (currentState == 1 || widget.newPet.petType == ''),
                          child: Row(
                            children: [
                              Text(
                                "# " + widget.newPet.petType,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 113, 113, 0.6)),
                              ),
                              SizedBox(width: 15.0),
                              Text("|  ",
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.3))),
                            ],
                          )),
                      Offstage(
                          offstage: (currentState == 1 || currentState == 2),
                          child: Row(
                            children: [
                              SizedBox(width: 15.0),
                              Text(
                                "# " + widget.newPet.petSpecies,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 113, 113, 0.6)),
                              ),
                            ],
                          )),

                    ])),  //선택한 펫 종류
              ),  //텍스트창
            ),
            SizedBox(height: 24), //공백
            //버튼 패널
            if (currentState == 1) firstCategory(),
            if (currentState == 2) secondCategory(),
            if (currentState == 3) thirdCategory()
          ],
        ),
      ),
    );
  }

  //펫 종류 선택
  firstCategory() {
    var height = MediaQuery.of(context).size.height / 800;
    return Offstage(
      offstage: currentState != 1, // offstage : true 이면 위젯이 사라짐.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("반려동물의 종류를 선택해주세요 !", style: TextStyle(fontSize: 14)),
          SizedBox(height: height * 90),
          Container(
            height: height*30,
            child: CupertinoScrollbar(
              // 스크롤 바 쓸때만 주석해제하기
              // thickness: 5.0, // 일반 스크롤 두께
              // thicknessWhileDragging: 8.0, // 드래그할 때 스크롤 두께
              // radius: Radius.circular(34.0), // 스크롤바 둥글게
              // isAlwaysShown: true, // 스크롤바 항상 노출
              child:
              //서버로부터 전송받은 리스트
              ListView.builder(
                scrollDirection: Axis.horizontal, // ListView 가로 설정
                  itemCount: PetInfo.petTypes.keys.toList().length, // petTypes의 각 key의 List 순회
                  itemBuilder: (context, i) =>
                      HashTagButton(
                          text: PetInfo.petTypes.keys.toList()[i],
                          onPressed: (){
                            setState(() {
                              currentState++;
                              widget.newPet.petType = PetInfo.petTypes.keys.toList()[i]; // 선택한 petType name string을 selectedPetTypeName에 대입
                              debugPrint(currentState.toString());
                            });
                          })
              ),
            ),
          ),
        ],
      ),
    );
  }

  //펫 세부 종 선택
  secondCategory() {
    var width = MediaQuery.of(context).size.width / 360;
    var height = MediaQuery.of(context).size.height / 800;
    return Offstage(
      // offstage : true 이면 위젯이 사라짐 / widget.newPet.petType!='' : 펫타입이 빈값이 아니여야 함
      offstage: !(currentState == 2 && widget.newPet.petType != ''),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("반려동물 세부 종을 선택해주세요 !",
              style: TextStyle(fontSize: 14)),
          SizedBox(height: height * 90),
          Container(
            height: height*30,
            child: CupertinoScrollbar(
              thickness: 5.0, // 일반 스크롤 두께
              thicknessWhileDragging: 8.0, // 드래그할 때 스크롤 두께
              radius: Radius.circular(34.0), // 스크롤바 둥글게
              isAlwaysShown: true, // 스크롤바 항상 노출
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // scrollDirection: 가로 스크롤 생성
                  itemCount: PetInfo.petTypes[widget.newPet.petType]!.length,
                  itemBuilder: (context, i) =>
                      HashTagButton(
                      text: PetInfo.petTypes[widget.newPet.petType]![i],
                      onPressed: (){
                        setState(() {
                          currentState++; // index : 2 -> 3,
                          widget.newPet.petSpecies
                          = PetInfo.petTypes[widget.newPet.petType]![i]; // 펫 세부 종 대입
                          debugPrint(currentState.toString()); // debug 창 띄우기
                        });
                      })
              ),
            ),
          ),
        ],
      ),
    );
  }
  thirdCategory(){
    return Offstage(
      offstage: currentState !=3,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*50/800),
          Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*30/360),
            child: customPinkElevatedButton("입력 완료", () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: FifthRoute(newPet: widget.newPet),
                      type: PageTransitionType.rightToLeft));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => FifthRoute(newPet : widget.newPet)));
            }),
          ),
        ],
      ),
    );
  }
  //펫 세부 정보 입력 페이지로 이동
  // moveToFifthRoute(){
  //   //widget.newPet.petType
  //   //widget.newPet.petSpecies
  //   return Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => FifthRoute(newPet : widget.newPet)));
  // }
}

class FifthRoute extends StatefulWidget {
  final PetInfo newPet;
  const FifthRoute({Key? key, required this.newPet}) : super(key: key);

  @override
  _FifthRouteState createState() => _FifthRouteState();
}
// 펫 세부 정보 입력 (마지막 페이지)
class _FifthRouteState extends State<FifthRoute> {
  TextEditingController _petAgeController = TextEditingController();
  TextEditingController _petBodyLengthController = TextEditingController();
  TextEditingController _petWeightController = TextEditingController();

  final _scrollController = ScrollController();

  String _msg = ''; // 뒤로가기 방지 메시지

  int numOfSelectedAllergy = 1; // 선택된 알러지 버튼의 개수
  int numOfSelectedDisease = 1; // 선택된 질병 버튼의 개수

  //파이어베이스 스테이트
  bool _initialized = false;
  bool _error = false;

  //파이어베이스 이니셜
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  //생성된 펫 정보를 서버로 전송 (현재 펫 데이터 = 펫 ID)
  void sendPetData(PetInfo petData) {
    //펫 정보 없을 바로 종료
    if(petData.petName == "")
      return;

    if (Logger().userData.uid != 0) {
      CollectionReference pets = FirebaseFirestore.instance.collection(
          'UserData').doc(Logger().userData.uid.toString()).collection('Pets');
      pets.doc(petData.petName).set({
        //pet id 설정 후 입력
        'Name': petData.petName,
        'Type' : petData.petType,
        'Species' : petData.petSpecies,
        'Age': petData.petAge,
        'BodyLength': petData.petBodyLength,
        'Weight': petData.petWeight,
        'Silhouette': petData.petSilhouette,
        'AllergyList': petData.petAllergyList,
        'DiseaseList' : petData.petDiseaseList,
      });
    }
    else
      throw Exception('Login Data Not Exist');
  }

  @override
  void initState() {
    initializeFlutterFire();
    widget.newPet.petAllergyList=[];
    widget.newPet.petDiseaseList=[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myInfo = Logger().userData;
    var width = MediaQuery.of(context).size.width / 360;
    var height = MediaQuery.of(context).size.height / 800;

    return WillPopScope(
      onWillPop: () {
        setState(() {
          _msg = "프로필 작성을 마무리 해주세요!";
        });
        return Future(() => false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 30),
            child: ListView(
                controller: _scrollController,
                children: <Widget>[
                  // --------------------------1번째 페이지
                  Container(
                    height: height*800,
                    child: Column(
                      children: [
                        SizedBox(height: height*50),
                        // 뒤로가기 버튼
                        customArrowBack(context),
                        SizedBox(height: height*25),
                        // 친구에 대해 더 자세히\n가르쳐 주세요!
                        Container(
                          alignment: Alignment.centerLeft,
                          child: customTitleQuestion(
                              "친구에 대해 ", "더 자세히\n", "가르쳐 주세요!"),
                        ),
                        SizedBox(height: height*20),
                        // 선택한 해시태그 출력 텍스트 Row
                        Row(
                          children: [
                            Text("# "+ widget.newPet.petType,
                              style: TextStyle(
                                color: PINK,
                              ),),
                            SizedBox(width:20),
                            Text("# "+ widget.newPet.petSpecies,
                              style: TextStyle(
                                color: PINK,
                              ),),
                          ],
                        ),
                        SizedBox(height: height*40),
                        customSubtitleQuestion('나이 (살)'),
                        SizedBox(height: height*20),
                        customTextFormField(
                            _petAgeController, '나이를 입력해 주세요.'),

                        SizedBox(height: height*40),
                        customSubtitleQuestion('몸 길이 (cm)'),
                        SizedBox(height: height*20),
                        customTextFormField(
                            _petBodyLengthController, '몸 길이를 입력해 주세요.'),


                        SizedBox(height: height*40),
                        customSubtitleQuestion('몸무게 (kg)'),
                        SizedBox(height: height*20),
                        customTextFormField(
                            _petWeightController, '몸무게를 입력해 주세요.'),

                        SizedBox(height: height*45),
                        customPinkElevatedButton( "입력 완료 !", (){
                          //입력한 나이, 몸길이, 몸무게를 생성자 newPet의 변수에 대입하는 코드
                          widget.newPet.petAge = int.parse(_petAgeController.text);
                          widget.newPet.petBodyLength = double.parse(_petBodyLengthController.text);
                          widget.newPet.petWeight = double.parse(_petWeightController.text);
                          // 디버그 창으로 확인하기(0으로 초기화 여부)
                          debugPrint("widget.newPet.petAge의 값: "+ widget.newPet.petAge.toString());
                          debugPrint("widget.newPet.petBodyLength의 값: "+ widget.newPet.petBodyLength.toString());
                          debugPrint("widget.newPet.petWeight의 값: "+ widget.newPet.petWeight.toString());
                          // 값 대입 후, 밑에 페이지로 자동 스크롤 애니메이션
                          _scrollController.animateTo(height*800,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        }),
                        SizedBox(height: height*22),
                        customPinkElevatedButton( "나중에 입력할게요", (){
                          // 나이, 몸길이, 몸무게 초기화(=0 대입)하는 코드
                          widget.newPet.petAge=0;
                          widget.newPet.petBodyLength=0;
                          widget.newPet.petWeight=0;
                          // 디버그 창으로 확인하기(0으로 초기화 여부)
                          debugPrint("widget.newPet.petAge의 값: "+ widget.newPet.petAge.toString());
                          debugPrint("widget.newPet.petBodyLength의 값: "+ widget.newPet.petBodyLength.toString());
                          debugPrint("widget.newPet.petWeight의 값: "+ widget.newPet.petWeight.toString());
                          // 값 대입 후, 밑에 페이지로 자동 스크롤 애니메이션
                          _scrollController.animateTo(height*800,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        }),
                      ],
                    ),
                  ),
                  // --------------------------2번째 페이지
                  Container(
                    height: height*800,
                    child: Column(
                      children: [
                        SizedBox(height: height*97),
                        Container(
                          alignment: Alignment.centerLeft,
                            child: customSemiTitleQuestion('', '${widget.newPet.petName}의', ' 실루엣은?')
                        ),
                        SizedBox(height: height*30),
                        Expanded(
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(), // gridview 내부 스크롤 기능 off
                            crossAxisCount: 2,
                            mainAxisSpacing: 18.0,
                            crossAxisSpacing: 18.0,
                            children: [
                              GestureDetector(
                                  child: silhouetteCard('images/bcs/bcs1.png',
                                      'BCS 1,2단계(야윈상태)', '갈비뼈, 허리뼈, 골반뼈가 드러나 보임'),
                                  onTap: () => {
                                    widget.newPet.petSilhouette = PetSilhouette.BCS1,
                                    // 디버그 창에 정상 대입 여부 출력
                                    debugPrint("widget.newPet.petSilhouette의 값: " + PetSilhouette.BCS1.toString()),
                                    // 값 대입 후, 밑에 페이지로 자동 스크롤 애니메이션
                                    _scrollController.animateTo(height*1600,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.fastOutSlowIn)
                                  }),
                              GestureDetector(
                                  child: silhouetteCard('images/bcs/bcs2.png',
                                      'BCS 3단계(저체중)', '갈비뼈가 쉽게 만져짐'),
                                  onTap: () => {
                                    widget.newPet.petSilhouette = PetSilhouette.BCS2,
                                    // 디버그 창에 정상 대입 여부 출력
                                    debugPrint("widget.newPet.petSilhouette의 값: " + PetSilhouette.BCS2.toString()),
                                    // 값 대입 후, 밑에 페이지로 자동 스크롤 애니메이션
                                    _scrollController.animateTo(height*1600,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.fastOutSlowIn)
                                  }),
                              GestureDetector(
                                  child: silhouetteCard('images/bcs/bcs3.png',
                                      'BCS 4,5단계(이상적인 체중)', '갈비뼈가 안보이지만 살짝 만져짐'),
                                  onTap: () => {
                                    widget.newPet.petSilhouette = PetSilhouette.BCS3,
                                    // 디버그 창에 정상 대입 여부 출력
                                    debugPrint("widget.newPet.petSilhouette의 값: " + PetSilhouette.BCS3.toString()),
                                    // 값 대입 후, 밑에 페이지로 자동 스크롤 애니메이션
                                    _scrollController.animateTo(height*1600,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.fastOutSlowIn)
                                  }),
                              GestureDetector(
                                  child: silhouetteCard('images/bcs/bcs4.png',
                                      'BCS 6단계(과체중)', '위에서 허리를 확인하기 힘듦'),
                                  onTap: () => {
                                    widget.newPet.petSilhouette = PetSilhouette.BCS4,
                                    // 디버그 창에 정상 대입 여부 출력
                                    debugPrint("widget.newPet.petSilhouette의 값: " + PetSilhouette.BCS4.toString()),
                                    // 값 대입 후, 밑에 페이지로 자동 스크롤 애니메이션
                                    _scrollController.animateTo(height*1600,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.fastOutSlowIn)
                                  }),
                              GestureDetector(
                                  child: silhouetteCard('images/bcs/bcs5.png',
                                      'BCS 8,9단계(비만)', '손에 힘을 주고 만져야 갈비뼈가 만져짐'),
                                  onTap: () => {
                                    widget.newPet.petSilhouette = PetSilhouette.BCS5,
                                    // 디버그 창에 정상 대입 여부 출력
                                    debugPrint("widget.newPet.petSilhouette의 값: " + PetSilhouette.BCS5.toString()),
                                    // 값 대입 후, 밑에 페이지로 자동 스크롤 애니메이션
                                    _scrollController.animateTo(height*1600,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.fastOutSlowIn)
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // --------------------------3번째 페이지
                  Container(
                    height : height * 800,
                    child: Column(
                      children: [
                        SizedBox(height: height*238),
                        Container(
                          alignment: Alignment.centerLeft,
                            child: customSemiTitleQuestion('', '알러지나 질병', '이 있나요?')
                        ),
                        SizedBox(height: height * 100),
                        customPinkElevatedButton("네", () {
                          // 알러지 입력창 이동
                          _scrollController.animateTo(height*800*3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        }),
                        SizedBox(height: height * 25),
                        customPinkElevatedButton(
                            "잘 모르겠어요!(나중에 입력할게요)", (){
                          // Logger().sendUserData(
                          //   petData.
                          // );
                          // widget.newPet.petAge = _petAgeController.text;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                                  (Route<dynamic> route) => false);
                        })
                      ],
                    ),
                  ),
                  // --------------------------4번째 페이지
                  Container(
                    height: height * 800,
                    child: Column(
                      children: [
                        SizedBox(height: height*238),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: customSemiTitleQuestion('', '알러지가', '  있나요?')
                        ),
                        SizedBox(height: height*33),
                        // 해시태그 표시 카드 박스
                        Container(
                          width: width * 300,
                          height: 70,
                          child: Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            //선택한 알러지값 노출
                            // child: Padding(
                            //     padding: EdgeInsets.symmetric(horizontal: 30.0),
                            //     // 표시될 #해시태그 리스트
                            //     child: Row(children: [
                            //       Offstage(
                            //           offstage: (numOfSelected == 1),
                            //           child: Row(
                            //             children: [
                            //               Text(
                            //                 "# " + widget.newPet.petAllergyList[0].toString(), //'1'번째 선택한 값 : petAllergyList['0']
                            //                 style: TextStyle(
                            //                     color: Color.fromRGBO(255, 113, 113, 0.6)),
                            //               ),
                            //               SizedBox(width: 15.0),
                            //               Text("|  ",
                            //                   style: TextStyle(
                            //                       color: Color.fromRGBO(0, 0, 0, 0.3))),
                            //             ],
                            //           )),
                            //       Offstage(
                            //           offstage: (numOfSelected==1 || numOfSelected==2),
                            //           child: Row(
                            //             children: [
                            //               SizedBox(width: 15.0),
                            //               Text(
                            //                 "# " + widget.newPet.petAllergyList[1].toString(),
                            //                 style: TextStyle(
                            //                     color: Color.fromRGBO(255, 113, 113, 0.6)),
                            //               ),
                            //               SizedBox(width: 15.0),
                            //               Text("|  ",
                            //                   style: TextStyle(
                            //                       color: Color.fromRGBO(0, 0, 0, 0.3))),
                            //             ],
                            //           )),
                            //       Offstage(
                            //           offstage: (numOfSelected==1 || numOfSelected==2 || numOfSelected == 3),
                            //           child: Row(
                            //             children: [
                            //               SizedBox(width: 15.0),
                            //               Text(
                            //                 "# " + widget.newPet.petAllergyList[2].toString(),
                            //                 style: TextStyle(
                            //                     color: Color.fromRGBO(255, 113, 113, 0.6)),
                            //               ),
                            //             ],
                            //           )),
                            //     ])),
                          ),
                        ),
                        SizedBox(height: height*25),
                        Text("알러지 항목을 골라주세요!(최대 3개)", style: TextStyle(fontSize: 14)),
                        Text("알러지가 없다면, '없음'을 입력해 주세요.", style: TextStyle(fontSize: 14)),
                        SizedBox(height: height*50),
                        // 알러지 목록들 ListView
                        Container(
                          height: height* 30,
                          child: CupertinoScrollbar(
                            // 일반 스크롤 두께
                            thickness: 5.0,
                            // 드래그할 때 스크롤 두께
                            thicknessWhileDragging: 8.0,
                            // 스크롤바 둥글게
                            radius: Radius.circular(34.0),
                            // 스크롤바 항상 노출
                            isAlwaysShown: true,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal, // ListView 가로 설정
                                itemCount: PetInfo.allergies.length, // pet의 allergy 각 List 순회
                                // .toList().length, // petTypes의 각 key의 List 순회
                                itemBuilder: (context, i) =>
                                    HashTagButton(
                                    text: PetInfo.allergies[i],
                                    // text: PetInfo.allergies.toList()[i],
                                    onPressed: () {
                                      setState(() {
                                        if (numOfSelectedAllergy  < 3){
                                          widget.newPet.petAllergyList
                                              .add(PetInfo.allergies[i]);
                                          // .add(PetInfo.allergies.toList()[i]);
                                          debugPrint("$numOfSelectedAllergy 번째 선택된 알러지는 : "
                                              + widget.newPet.petAllergyList[numOfSelectedAllergy-1].toString());
                                          debugPrint("현재 widget.newPet.petAllergyList 값:" + widget.newPet.petAllergyList.toString());
                                          numOfSelectedAllergy++; // 1 -> 2 | 2 -> 3 | 3-> 4
                                        }
                                        else { // 알러지 3개 입력 완료하면
                                          debugPrint("알러지 입력을 이미 완료하였으므로, 다음 창으로 넘어갑니다.");
                                          _scrollController.animateTo(height*800*4,
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.fastOutSlowIn);
                                        }
                                      });
                                    })),
                          ),
                        ),
                        SizedBox(height: height*30),
                        //해당 없음 버튼
                        customPinkElevatedButton("해당 없음", () {
                          // 알러지 입력창 이동
                          _scrollController.animateTo(height*800*5,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        }),
                      ],
                    ),
                  ),
                  // --------------------------5번째 페이지
                  Container(
                    height: height * 800,
                    child: Column(
                      children: [
                        SizedBox(height: height*238),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: customSemiTitleQuestion('', '질병이', '  있나요?')
                        ),
                        SizedBox(height: height*33),
                        // 해시태그 표시 카드 박스
                        Container(
                          width: width * 300,
                          height: 70,
                          child: Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            //선택한 알러지값 노출
                            // child: Padding(
                            //     padding: EdgeInsets.symmetric(horizontal: 30.0),
                            //     // 표시될 #해시태그 리스트
                            //     child: Row(children: [
                            //       Offstage(
                            //           offstage: (numOfSelected == 1),
                            //           child: Row(
                            //             children: [
                            //               Text(
                            //                 "# " + widget.newPet.petAllergyList[0].toString(), //'1'번째 선택한 값 : petAllergyList['0']
                            //                 style: TextStyle(
                            //                     color: Color.fromRGBO(255, 113, 113, 0.6)),
                            //               ),
                            //               SizedBox(width: 15.0),
                            //               Text("|  ",
                            //                   style: TextStyle(
                            //                       color: Color.fromRGBO(0, 0, 0, 0.3))),
                            //             ],
                            //           )),
                            //       Offstage(
                            //           offstage: (numOfSelected==1 || numOfSelected==2),
                            //           child: Row(
                            //             children: [
                            //               SizedBox(width: 15.0),
                            //               Text(
                            //                 "# " + widget.newPet.petAllergyList[1].toString(),
                            //                 style: TextStyle(
                            //                     color: Color.fromRGBO(255, 113, 113, 0.6)),
                            //               ),
                            //               SizedBox(width: 15.0),
                            //               Text("|  ",
                            //                   style: TextStyle(
                            //                       color: Color.fromRGBO(0, 0, 0, 0.3))),
                            //             ],
                            //           )),
                            //       Offstage(
                            //           offstage: (numOfSelected==1 || numOfSelected==2 || numOfSelected == 3),
                            //           child: Row(
                            //             children: [
                            //               SizedBox(width: 15.0),
                            //               Text(
                            //                 "# " + widget.newPet.petAllergyList[2].toString(),
                            //                 style: TextStyle(
                            //                     color: Color.fromRGBO(255, 113, 113, 0.6)),
                            //               ),
                            //             ],
                            //           )),
                            //     ])),
                          ),
                        ),
                        SizedBox(height: height*25),
                        Text("질병 항목을 골라주세요.(최대 3개)", style: TextStyle(fontSize: 14)),
                        Text("앓고있는 질병이 없다면, '없음'을 입력해 주세요.", style: TextStyle(fontSize: 14)),
                        SizedBox(height: height*50),
                        // 알러지 목록들 ListView
                        Container(
                          height: height*30,
                          child: CupertinoScrollbar(
                            // 일반 스크롤 두께
                            thickness: 5.0,
                            // 드래그할 때 스크롤 두께
                            thicknessWhileDragging: 8.0,
                            // 스크롤바 둥글게
                            radius: Radius.circular(34.0),
                            // 스크롤바 항상 노출
                            isAlwaysShown: true,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal, // ListView 가로 설정
                                itemCount: PetInfo.diseases.length, // pet의 allergy 각 List 순회
                                // .toList().length, // petTypes의 각 key의 List 순회
                                itemBuilder: (context, i) =>
                                    HashTagButton(
                                        text: PetInfo.diseases[i],
                                        onPressed: () {
                                          setState(() {
                                            if (numOfSelectedDisease  < 3){
                                              widget.newPet.petDiseaseList
                                                  .add(PetInfo.diseases[i]);
                                              debugPrint("$numOfSelectedDisease 번째 선택된 알러지는 : "
                                                  + widget.newPet.petDiseaseList[numOfSelectedDisease-1].toString());
                                              debugPrint("현재 widget.newPet.petDiseaseList 값:" + widget.newPet.petDiseaseList.toString());
                                              numOfSelectedDisease++; // 1 -> 2 | 2 -> 3 | 3-> 4
                                            }
                                            else { // 질병 3개 입력 완료하면
                                              debugPrint("질병 입력을 이미 완료하였습니다. 메인 화면으로 이동해주세요.");
                                            }
                                          });
                                        })),
                          ),
                        ),
                        SizedBox(height: height*30),
                        //해당 없음 버튼
                        customPinkElevatedButton("해당 없음", () {
                          // 알러지 입력창 이동
                          // _scrollController.animateTo(height*800*5,
                          //     duration: Duration(milliseconds: 500),
                          //     curve: Curves.fastOutSlowIn);
                        }),
                        SizedBox(height: height*25),
                        customPinkElevatedButton(
                          //-------- + 작성한 생성자를 서버로 전송하는 코드(sendUserData)----------
                          // Logger().userData.myPets.????
                          //-------- + 작성한 생성자를 서버로 전송하는 코드(sendUserData)----------
                            "작성 완료! 메인 화면으로 이동", (){
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                                  (Route<dynamic> route) => false);
                        })
                      ],
                    ),
                  ),

                  // if (currentState==2) secondCategory(),
                  // if (currentState==3) thirdCategory(),
                  // if (currentState==4) fourthCategory(),
                ]
            ),),),
      ),
    );
  }
  // thirdCategory() {
  //   var width = MediaQuery.of(context).size.width / 360;
  //   var height = MediaQuery.of(context).size.height / 800;
  //   return Offstage(
  //     offstage: !(currentState == 3), // offstage : true 이면 위젯이 사라짐
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Container(
  //           width: width * 300,
  //           height: 70,
  //           child: Card(
  //             elevation: 2.0,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12.0)),
  //             child: Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 30.0),
  //                 child: Row(children: [
  //                   Offstage(
  //                       offstage: (diseaseCountState == 0),
  //                       child: Row(
  //                         children: [
  //                           Text(
  //                             "# " + widget.newPet.petDiseaseList[0],
  //                             style: TextStyle(
  //                                 color: Color.fromRGBO(255, 113, 113, 0.6)),
  //                           ),
  //                           SizedBox(width: 15.0),
  //                           Text("|  ",
  //                               style: TextStyle(
  //                                   color: Color.fromRGBO(0, 0, 0, 0.3))),
  //                         ],
  //                       )),
  //                   Offstage(
  //                       offstage: ((diseaseCountState == 0) || (diseaseCountState == 1)),
  //                       child: Row(
  //                         children: [
  //                           SizedBox(width: 15.0),
  //                           Text(
  //                             "# " + widget.newPet.petDiseaseList[1],
  //                             style: TextStyle(
  //                                 color: Color.fromRGBO(255, 113, 113, 0.6)),
  //                           ),
  //                           SizedBox(width: 15.0),
  //                           Text("|  ",
  //                               style: TextStyle(
  //                                   color: Color.fromRGBO(0, 0, 0, 0.3))),
  //                         ],
  //                       )),
  //                   Offstage(
  //                       offstage: ((diseaseCountState == 0) || (diseaseCountState == 1) || (diseaseCountState == 2)),
  //                       child: Row(
  //                         children: [
  //                           SizedBox(width: 15.0),
  //                           Text(
  //                             "# " + widget.newPet.petDiseaseList[2],
  //                             style: TextStyle(
  //                                 color: Color.fromRGBO(255, 113, 113, 0.6)),
  //                           ),
  //                         ],
  //                       )),
  //                 ])),  //선택한 펫 종류
  //           ),  //텍스트창
  //         ),
  //         SizedBox(height: height*25),
  //         Text("질병 항목을 골라주세요!(최대 3개)",
  //             style: TextStyle(fontSize: 14)),
  //         SizedBox(height: height * 50),
  //         Container(
  //           height: 80.0,
  //           child: CupertinoScrollbar(
  //             thickness: 5.0,
  //             // 일반 스크롤 두께
  //             thicknessWhileDragging: 8.0,
  //             // 드래그할 때 스크롤 두께
  //             radius: Radius.circular(34.0),
  //             // 스크롤바 둥글게
  //             isAlwaysShown: true,
  //             // 스크롤바 항상 노출
  //             child: ListView.builder(
  //                 scrollDirection: Axis.horizontal, // ListView 가로 설정
  //                 itemCount: PetInfo.diseases.length, // List 순회
  //                 itemBuilder: (context, i) => HashTagButton(
  //                     text: PetInfo.diseases[i],
  //                     //text: PetInfo.diseases.toList()[i],
  //                     onPressed: () {
  //                       setState(() {
  //                         diseaseCountState++;
  //                         widget.newPet.petDiseaseList
  //                             .add(PetInfo.diseases[i]);
  //                         //.add(PetInfo.diseases.toList()[i]);
  //                         debugPrint(diseaseCountState.toString());
  //                         if (diseaseCountState == 3) {
  //                           // 질병 3개 입력 완료하면
  //                           currentState++; // 3 -> 4
  //                         }
  //                       });
  //                     })),
  //           ),
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }
  // fourthCategory(){
  //   return Offstage(
  //     offstage: !(currentState == 4),
  //     child: Column(
  //       children: [
  //         SizedBox(height: MediaQuery.of(context).size.height*50/800),
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*30/360),
  //           child: customPinkElevatedButton("입력 완료", () {
  //             Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => MyHomePage()),
  //                     (route) => false);
  //           }),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

//-----------------각종 function, methods 모음-------------------------
Card customTextFormField(TextEditingController editingController, String hint) {
  return Card(
    elevation: 5.0, // 카드박스 그림자 음영
    //margin: EdgeInsets.only(top: 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: Container(
      width: double.infinity,
      height: 52.0,
      padding: EdgeInsets.only(left: 20),
      child: TextFormField(
          controller: editingController,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: GREY)),
          cursorColor: GREY,
          //테스트용 코드
          onChanged: (text) {
            print(text);
          }),
    ),
  );
}

GestureDetector customArrowBack(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      alignment: Alignment.centerLeft,
      child: Icon(
        Icons.arrow_back_ios_sharp,
        size: 100.0,
        color: GREY,
      ),
    ),
  );
}

Container customPinkElevatedButton(String text, VoidCallback onPressed) {
  return Container(
    //margin: EdgeInsets.only(left: 40, right: 40),
    child: SizedBox(
      width: double.infinity,
      height: 52.0,
      child: ElevatedButton(
          child: Text(text),
          style: ElevatedButton.styleFrom(
              primary: PINK,
              onPrimary: Colors.white,
              textStyle: TextStyle(fontSize: 14
                  //fontWeight: FontWeight.bold
                  ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0))),
          onPressed: onPressed),
    ),
  );
}

Text customSemiTitleQuestion(
    String commonText1, String highlightText, String commonText2) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
            text: commonText1,
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: highlightText,
            style: TextStyle(
              color: PINK,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            )),
        TextSpan(
            text: commonText2,
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Text customTitleQuestion(
    String commonText1, String highlightText, String commonText2) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
            text: commonText1,
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: highlightText,
            style: TextStyle(
              color: PINK,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            )),
        TextSpan(
            text: commonText2,
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Text customSubtitleQuestion(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),
  );
}

Text customSubtitleColor(String text, Color color) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: 12.0, fontWeight: FontWeight.bold),
  );
}

Text customSubtitleColorUnderline(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        color: color,
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline),
  );
}

Text customSubtitleQuestionColor(String text) {
  return Text(
    text,
    style: TextStyle(color: PINK, fontSize: 14.0, fontWeight: FontWeight.bold),
  );
}

Text customSubtitleQuestionFontSize(String text, double fontSize) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.bold),
  );
}

Card silhouetteCard(String imagePath, String bcsLevel, String bcsState) {
  return Card(
    elevation: 10.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: SizedBox(
      // 가장 외곽의 카드 박스
      width: 135,
      height: 200,
      child: Column(
        children: [
          SizedBox(height: 30.0),
          Expanded(
            flex: 5,
            child: Container(
              child: SizedBox(
                width: 130.0,
                height: 150.0,
                child: Image.asset(imagePath),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                bcsLevel,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: PINK,
                  fontSize: 10.0,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                bcsState,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0)
        ],
      ),
    ),
  );
}