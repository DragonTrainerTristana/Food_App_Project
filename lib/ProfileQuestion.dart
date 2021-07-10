import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_service_application/HashTagButtonList.dart';
import 'package:pet_service_application/main.dart';

const Color PINK = const Color.fromRGBO(255, 113, 113, 1);
const Color LIGHTPINK = const Color.fromRGBO(255, 113, 113, 0.3);
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
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(50),
              child: customTitleQuestion('', '당신의 이름', '을\n알고 싶어요!'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 50, left: 40, right: 40),
              child: Column(
                children: [
                  customTextFormField('사용자의 이름을 입력해주세요.'),
                  SizedBox(height: 20.0),
                  customPinkElevatedButton("입력 완료!", context, SecondRoute()),
                ],
              ),
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
        children: [
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25.0, top: 110.0),
                      child: customArrowBack(context),
                    ),
                    SizedBox(height: 25.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 50, right: 50),
                      child: customTitleQuestion(
                          "함께하고 계신 ", "친구들에 대해\n", "이야기 해 주실 수 있으신가요?"),
                    ),
                    SizedBox(height: 26.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 50, right: 50),
                      child: customSubtitleQuestion("추후 마이페이지에서 다시 설정 가능합니다."),
                    )
                  ],
                ),
              )),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(50),
              child: Column(
                children: [
                  customPinkElevatedButton("네!", context, ThirdRoute()),
                  SizedBox(height: 20.0),
                  customPinkElevatedButton(
                      "아니요..ㅠㅠ바로 앱으로!", context, MyHomePage(title: appName)),
                ],
              ),
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
      body: Column(children: [
        Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25.0, top: 110.0),
                    child: customArrowBack(context),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: customTitleQuestion("친구의 ", "이름은?", ""),
                  ),
                  SizedBox(height: 26.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: customSubtitleQuestion(
                        "2마리 이상일 시,\n마이페이지에서 친구를 추가할 수 있습니다."),
                  )
                ],
              ),
            )),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(top: 50, left: 40, right: 40),
            child: Column(
              children: [
                customTextFormField('반려동물의 이름을 입력해주세요!'),
                SizedBox(height: 20.0),
                customPinkElevatedButton("입력 완료!", context, FourthRoute()),
              ],
            ),
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
  @override
  Widget build(BuildContext context) {
    PetCategoryListView petCategoryListView =
        PetCategoryListView(petCategoryStrList: []);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25.0, top: 110.0),
                      child: customArrowBack(context),
                    ),
                    SizedBox(height: 25.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 50, right: 50),
                      child:
                          customTitleQuestion("친구에 대해 ", "더 자세히\n", "가르쳐 주세요!"),
                    ),
                    SizedBox(height: 26.0),
                    Container(
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                        child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            width: double.infinity,
                            height: 60,
                            child: petCategoryListView),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Column(children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    children: [
                      SizedBox(height: 15.0),
                      customSubtitleQuestion('(반려동물 종류)를 선택해 주세요!')
                    ],
                  ),
                ),
                SizedBox(height: 45.0),
                HashTagButtonListManager(
                    petCategoryListView: petCategoryListView)
              ])),
        ],
      ),
    );
  }
}

class HashTagButtonListManager extends StatefulWidget {
  final PetCategoryListView petCategoryListView;

  HashTagButtonListManager({Key? key, required this.petCategoryListView})
      : super(key: key);

  final _HashTagButtonListManager listManager = _HashTagButtonListManager();

  _HashTagButtonListManager getStateData() => listManager;

  @override
  _HashTagButtonListManager createState() => listManager;
}

class _HashTagButtonListManager extends State<HashTagButtonListManager> {
  bool isCategorySelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return selectHashTagButtonList();
  }

  void refresh(bool _isSelected) {
    setState(() {
      isCategorySelected = _isSelected;
    });
  }

  Widget selectHashTagButtonList() {
    if (!isCategorySelected)
      return HashTagInputButtonList(manager: widget);
    else
      return HashTagInputButtonSecondList(manager: widget);
  }
}

class HashTagInputButtonList extends StatelessWidget {
  final HashTagButtonListManager manager;

  HashTagInputButtonList({Key? key, required this.manager});

  ElevatedButton buildHashTagButton(String buttonText, BuildContext context) {
    return ElevatedButton(
        child: Text(buttonText),
        onPressed: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context) => FifthRoute()));
          manager.getStateData().refresh(true);
          manager.petCategoryListView.getStateData().add(buttonText);
        },
        style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(246, 246, 246, 1),
            onPrimary: PINK,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildHashTagButton('#강아지', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#고양이', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#햄스터', context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildHashTagButton('#기니피그', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#카멜레온', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#오소리', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#너구리', context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildHashTagButton('#앵무새', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#사자', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#호랑이', context),
            ],
          )
        ],
      ),
    );
  }
}

class HashTagInputButtonSecondList extends StatelessWidget {
  final HashTagButtonListManager manager;

  HashTagInputButtonSecondList({Key? key, required this.manager});

  ElevatedButton buildHashTagButton(String buttonText, BuildContext context) {
    return ElevatedButton(
        child: Text(buttonText),
        onPressed: () {
          manager.getStateData().refresh(true);
          manager.petCategoryListView.getStateData().add(buttonText);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FifthRoute(
                      petCategoryStrList: manager.petCategoryListView
                          .getStateData()
                          .petCategoryStrList)));
        },
        style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(246, 246, 246, 1),
            onPrimary: PINK,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildHashTagButton('#말티즈', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#웰시코기', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#치와와', context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildHashTagButton('#도베르만', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#시바견', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#진돗개', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#풍산개', context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildHashTagButton('#시베리안 허스키', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#푸들', context),
              Padding(padding: EdgeInsets.all(20)),
              buildHashTagButton('#슈나우저', context),
            ],
          )
        ],
      ),
    );
  }
}

class FifthRoute extends StatefulWidget {
  final List<String> petCategoryStrList;

  const FifthRoute({Key? key, required this.petCategoryStrList})
      : super(key: key);

  @override
  _FifthRouteState createState() => _FifthRouteState();
}

class _FifthRouteState extends State<FifthRoute> {

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    PetCategoryListView petCategoryListView =
    PetCategoryListView(petCategoryStrList: []);

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25.0, top: 65.0),
                  child: customArrowBack(context),
                ),
                SizedBox(height: 25.0),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 50, right: 50),
                  child: customTitleQuestion("친구에 대해 ", "더 자세히\n", "가르쳐 주세요!"),
                ),
                SizedBox(height: 26.0),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                        children: [
                          customSubtitleQuestionColor(widget.petCategoryStrList[0]), // 데이터 변수값 수정해야 함
                          SizedBox(width: 12),
                          customSubtitleQuestionColor(widget.petCategoryStrList[1]), // 데이터 변수값 수정해야 함
                        ]
                    )
                ),
              ],
            ),
          ),
          Container(
            child: Column(children: [
              SizedBox(height: 15.0),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 50, right: 50),
                child: customSubtitleQuestion('나이'),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 40, right: 40),
                child: customTextFormField('나이를 입력해 주세요.'),
              )
            ]),
          ),
          Container(
            child: Column(children: [
              SizedBox(height: 30.0),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 50, right: 50),
                child: customSubtitleQuestion('몸 길이'),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 40, right: 40),
                child: customTextFormField('몸 길이 입력해 주세요.'),
              )
            ]),
          ),
          Container(
            child: Column(children: [
              SizedBox(height: 30.0),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 50, right: 50),
                child: customSubtitleQuestion('몸무게'),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 40, right: 40),
                child: customTextFormField('몸무게를 입력해 주세요.'),
              )
            ]),
          ),
          SizedBox(height: 75.0),
          Container(
              width: 60.0,
              height: 60.0,
              child: animationDownButton(_scrollController)),
          //--------------------------------------------1번째 화면
          SizedBox(height: 64.0),
          Container(
              width: 60.0,
              height: 60.0,
              child: animationUpButton(_scrollController)),
          SizedBox(height: 28.0),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 40),
              // 닉네임을 변수로 수정해야함!
              child: customSemiTitleQuestion('', '닉네임의', ' 실루엣은?')),

          SizedBox(height: 28.0),
          Container(
            height: 600,
            child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.only(left: 36.0, right: 36.0),
                mainAxisSpacing: 18.0,
                crossAxisSpacing: 18.0,
                children: [
                  silhouetteCard('images/bcs/bcs1.png', 'BCS 1,2단계(야윈상태)',
                      '갈비뼈, 허리뼈, 골반뼈가 드러나 보임'),
                  silhouetteCard(
                      'images/bcs/bcs2.png', 'BCS 3단계(저체중)', '갈비뼈가 쉽게 만져짐'),
                  silhouetteCard('images/bcs/bcs3.png', 'BCS 4,5단계(이상적인 체중)',
                      '갈비뼈가 안보이지만 살짝 만져짐'),
                  silhouetteCard(
                      'images/bcs/bcs4.png', 'BCS 6단계(과체중)', '위에서 허리를 확인하기 힘듦'),
                  silhouetteCard('images/bcs/bcs5.png', 'BCS 8,9단계(비만)',
                      '손에 힘을 주고 만져야 갈비뼈가 만져짐')
                ]),
          ),
          SizedBox(height: 106.0),
          Container(
              width: 60.0,
              height: 60.0,
              child: animationDownButton(_scrollController)),
          //---------------------------------2번째 페이지
          SizedBox(height: 64.0),
          Container(
              width: 60.0,
              height: 60.0,
              child: animationUpButton(_scrollController)),
          SizedBox(height: 150.0),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 50),
            child: customSemiTitleQuestion('', '알러지나 질병', '이 있나요?'),
          ),
          SizedBox(height: 37.0),

          // Container(
          //   margin: EdgeInsets.only(left: 40, right: 40),
          //   child: Card(
          //     elevation: 10.0,
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          //     child: Container(
          //         margin: EdgeInsets.only(left: 15, right: 15),
          //         width: double.infinity,
          //         height: 60,
          //         child: petCategoryListView),
          //   ),
          // ),
          // SizedBox(height: 24.0),
          // Container(
          //   alignment: Alignment.center,
          //   child: customSubtitleQuestion('(알러지)항목을 선택해 주세요.')
          // ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20,right: 20,top:50),
            child: AllergyButtonListManager(
                petCategoryListView: petCategoryListView)

            // child: Column(
            //   children: [
            //     customPinkElevatedButton(
            //         '네', context, MyHomePage(title: appName)),
            //     SizedBox(height: 30.0),
            //     customPinkElevatedButton(
            //         "아니요(잘 모르겠어요)", context, MyHomePage(title: appName)),
            //   ],
            // ),
          ),
          SizedBox(height: 371.0),
        ],
      ),
    );
  }
}

GestureDetector animationUpButton(ScrollController _scrollController) {
  return GestureDetector(
    onTap: () => {
      _scrollController.animateTo(_scrollController.position.extentBefore,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn)
    },
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: LIGHTPINK,
      ),
      child: Icon(
        Icons.keyboard_arrow_up,
        color: Colors.white,
        size: 30.0,
      ),
    ),
  );
}

GestureDetector animationDownButton(ScrollController _scrollController) {
  return GestureDetector(
    onTap: () => {
      _scrollController.animateTo(1122,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn)
    },
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: LIGHTPINK,
      ),
      child: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
        size: 30.0,
      ),
    ),
  );
}

Card customTextFormField(String hint) {
  final editingController = TextEditingController();
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
      ),
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

Container customPinkElevatedButton(
    String text, BuildContext context, Widget nextRoute) {
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
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => nextRoute));
        },
      ),
    ),
  );
}

GestureDetector customPinkAnimatedButton(
    String text, ScrollController scrollController) {
  return GestureDetector(
    child: Container(
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
          onPressed: () {
            scrollController.animateTo(scrollController.position.extentAfter,
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          },
        ),
      ),
    ),
  );
}

SizedBox customPinkOutlinedButton(
    String text, BuildContext context, Widget nextRoute) {
  return SizedBox(
    width: double.infinity,
    height: 52.0,
    child: OutlinedButton(
      child: Text(text),
      style: OutlinedButton.styleFrom(
          primary: PINK,
          textStyle: TextStyle(fontSize: 14
              //fontWeight: FontWeight.bold
              ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0))),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => nextRoute));
      },
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
Text customSubtitleQuestionColor(String text) {
  return Text(
    text,
    style: TextStyle(
        color: PINK, fontSize: 12.0, fontWeight: FontWeight.bold),
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
// --------------------알러지 버튼 리스트 매니저-------------------------
class AllergyButtonListManager extends StatefulWidget {
  final PetCategoryListView petCategoryListView;

  AllergyButtonListManager({Key? key, required this.petCategoryListView})
      : super(key: key);

  final _AllergyButtonListManager listManager = _AllergyButtonListManager();

  _AllergyButtonListManager getStateData() => listManager;

  @override
  _AllergyButtonListManager createState() => listManager;
}

class _AllergyButtonListManager extends State<AllergyButtonListManager> {
  bool isAllergySelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return selectHashTagButtonList();
  }

  void refresh(bool _isSelected) {
    setState(() {
      isAllergySelected = _isSelected;
    });
  }

  Widget selectHashTagButtonList() {
    if (!isAllergySelected)
      // 알러지나 질병이 있나요? Yes or No 버튼 창을 띄우고 싶음
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          children: [
            customPinkElevatedButton('네', context, MyHomePage(title: appName)),
            SizedBox(height: 30.0),
            customPinkElevatedButton(
                "아니요(잘 모르겠어요)", context, MyHomePage(title: appName)),
          ],
        ),
      );
    else // 알러지 항목을 선택하는 창을 띄우고 싶음
      return AllergyInputButtonList(manager: widget);
  }
}
class AllergyInputButtonList extends StatelessWidget {
  final AllergyButtonListManager manager;

  AllergyInputButtonList({Key? key, required this.manager});

  ElevatedButton buildAllergyButton(String buttonText, BuildContext context) {
    return ElevatedButton(
        child: Text(buttonText),
        onPressed: () {
          manager.getStateData().refresh(true);
          manager.petCategoryListView.getStateData().add(buttonText);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FifthRoute(
                      petCategoryStrList: manager.petCategoryListView
                          .getStateData()
                          .petCategoryStrList)));
        },
        style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(246, 246, 246, 1),
            onPrimary: PINK,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildAllergyButton('#비염', context),
              Padding(padding: EdgeInsets.all(20)),
              buildAllergyButton('#관절염', context),
              Padding(padding: EdgeInsets.all(20)),
              buildAllergyButton('#치주염', context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildAllergyButton('#백내장', context),
              Padding(padding: EdgeInsets.all(20)),
              buildAllergyButton('#녹내장', context),
              Padding(padding: EdgeInsets.all(20)),
              buildAllergyButton('#빈혈', context),
              Padding(padding: EdgeInsets.all(20)),
              buildAllergyButton('#간질발작', context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildAllergyButton('#소화불량', context),
              Padding(padding: EdgeInsets.all(20)),
              buildAllergyButton('#충치', context),
              Padding(padding: EdgeInsets.all(20)),
              buildAllergyButton('#기생충', context),
            ],
          )
        ],
      ),
    );
  }
}