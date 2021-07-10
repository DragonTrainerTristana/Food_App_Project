import 'package:flutter/material.dart';

import 'package:pet_service_application/CardNewsModel.dart';
import 'package:pet_service_application/appbar/DrawerWithAlarmAppBar.dart';
import 'package:pet_service_application/card_news_detail/CardNewsDetailRoute.dart';
import 'package:pet_service_application/CardNewsListRoute.dart';

// import 'package:pet_service_application/SeungHyun/screen/search_screen.dart';
// import 'package:pet_service_application/SeungHyun/screen/goods_screen.dart';
// import 'package:pet_service_application/SeungHyun/screen/detail_goods_screen.dart';

import 'package:pet_service_application/log_in/LogIn.dart';
import 'package:pet_service_application/ProfileQuestion.dart';

void main() => runApp(MyApp());

final String appName = "Pet App";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProfileQuestion()
        //home: MyHomePage(title: appName),
        );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Column 기준 정렬
            crossAxisAlignment: CrossAxisAlignment.center, // Row 기준 정렬
            children: <Widget>[
              // appbar 부분 구현
              DrawerWithAlarmAppBar(nickName: '닉네임'),
              GestureDetector(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardNewsListRoute()),
                      ),
                  child: Container(
                      alignment: Alignment.centerRight,
                      child: Text("더보기 >"),
                      margin: EdgeInsets.all(20.0))),
              Expanded(flex: 2, child: CardNewsPageView()),
              // 여기부분 부터 합치면 됩니다
              //검색 창 그림만들기 -> 클릭하면 다른 라우터로 이동합니다.
              // Expand 필요할 수도 있음
              Container(
                child: ElevatedButton(
                  child: Text('Go to the Search_Screen'),
                  onPressed: () {
                    /*
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchRoute()));*/
                  },
                ),
              ),
              // 또 item 추가 가능
            ]),
      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),bottomRight: Radius.circular(35),
        ),
        child: Drawer(     
          child: Column(
            //padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.arrow_back, color: Colors.grey[850]),
                          margin: EdgeInsets.all(20.0))),
                  GestureDetector(
                      onTap: () => {
                            //Navigator.push(context,Setting);
                          },
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.settings, color: Colors.grey[850]),
                          margin: EdgeInsets.all(20.0))),
                ],
              ),
              SizedBox(height: 130.0),
              CircleAvatar(
                radius: 110.0,
                backgroundColor: Color.fromRGBO(255, 113, 113, 1),
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundImage: AssetImage('images/logo_main.png'),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                '[펫이름]과 함께하는\n[닉네임]님',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                //'$PetName과 함께하는\n$NickName님'
              ),
              SizedBox(height: 60.0),
              ListTile(
                title: Text(
                  '친구의 정보',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  print('Profile is clicked');
                },
                //trailing: Icon(Icons.add) : +키 생략
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                // leading: Icon(
                //   Icons.check_box_outlined,
                //   color: Colors.grey[850],
                // ),
                title: Text(
                  '찜 목록',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  print('WishList is clicked');
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                // leading: Icon(
                //   Icons.shopping_cart_outlined,
                //   color: Colors.grey[850],
                // ),
                title: Text(
                  '장바구니',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  print('shopping_cart is clicked');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.login_outlined,
                  color: Colors.grey[850],
                ),
                title: Text('로그인 하기'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LogIn()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    //오래걸리는 작업을 수행할 떄
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: appName)));
  }

  //   Timer(
  //       Duration(seconds:3),
  //       ()=>Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context)=>MyHomePage(title: appName))
  //       )
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset('images/logo_main.png'),
    ));
  }
}

class CardNews extends StatelessWidget {
  final CardNewsModel cardNewsModel;
  final BorderRadius _baseBorderRadius = BorderRadius.circular(8);

  CardNews({Key? key, required this.cardNewsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CardNewsDetailRoute()),
            ),
        child: Card(
          elevation: 5,
          margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(borderRadius: _baseBorderRadius),
          child: Image.network(
            cardNewsModel.imgUrl,
            fit: BoxFit.fill,
          ),
        ));
  }
}

class CardNewsPageView extends StatefulWidget {
  @override
  _CardNewsPageView createState() => _CardNewsPageView();
}

class _CardNewsPageView extends State<CardNewsPageView> {
  List<CardNews> cardNewsList = [];

  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(viewportFraction: 0.85, initialPage: 0);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: cardNewsList,
    );
  }
}
