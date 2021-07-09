import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_service_application/CardNewsModel.dart';
import 'package:pet_service_application/appbar/DrawerWithAlarmAppBar.dart';
import 'package:pet_service_application/card_news_detail/CardNewsDetailRoute.dart';
import 'package:pet_service_application/CardNewsListRoute.dart';

import 'package:pet_service_application/SeungHyun/screen/search_screen.dart';
import 'package:pet_service_application/SeungHyun/screen/goods_screen.dart';
import 'package:pet_service_application/SeungHyun/screen/detail_goods_screen.dart';

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
      home: MyHomePage(title: appName),
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

      appBar: AppBar(
        title: DrawerWithAlarmAppBar(nickName: '닉네임'),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[


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


          RaisedButton.icon(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchRoute()));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text('상품 검색',
              style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.search, color:Colors.white,),
            textColor: Colors.white,
            splashColor: Colors.red,
            color: Colors.green,),

          Padding(padding: EdgeInsets.all(32)),

          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    '당신과 함께하는',
                  style: TextStyle(fontSize: 32),

                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  '사탕이',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 113, 113, 1),
                        decoration: TextDecoration.underline,
                        letterSpacing: 2.0,
                        fontSize: 32,fontWeight: FontWeight.bold
                    ),
                ),
                Text(
                  '를 위한',
                  style: TextStyle(
                      fontSize: 32,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  '건강 식단',
                  style: TextStyle(fontSize: 32),
                ),

              ],
            ),
          ),


          GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GoodsScreen()),
              ),
              child: Container(
                  alignment: Alignment.centerRight,
                  child: Text("더보기 >"),
                  margin: EdgeInsets.all(20.0))),


          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 220,
                  width: 220,
                  child: FlatButton(
                    onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => DetailedGoodsScreen()));},
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Icon(Icons.favorite),
                                ),
                                Text(
                                    '바로주문'
                                ),
                                GestureDetector(
                                  child: Icon(Icons.shopping_cart),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child:  Image.asset('images/goodstestimage.png'),
                          ),
                          Text('맛있는 개껌'),
                          Text('30,000원'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 220,
                  width: 220,
                  child: FlatButton(
                    onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => DetailedGoodsScreen()));},
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Icon(Icons.favorite),
                                ),
                                Text(
                                    '바로주문'
                                ),
                                GestureDetector(
                                  child: Icon(Icons.shopping_cart),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child:  Image.asset('images/goodstestimage.png'),
                          ),
                          Text('맛있는 개껌'),
                          Text('30,000원'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 220,
                  width: 220,
                  child: FlatButton(
                    onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => DetailedGoodsScreen()));},
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Icon(Icons.favorite),
                                ),
                                Text(
                                    '바로주문'
                                ),
                                GestureDetector(
                                  child: Icon(Icons.shopping_cart),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child:  Image.asset('images/goodstestimage.png'),
                          ),
                          Text('맛있는 개껌'),
                          Text('30,000원'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 220,
                  width: 220,
                  child: FlatButton(
                    onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => DetailedGoodsScreen()));},
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Icon(Icons.favorite),
                                ),
                                Text(
                                    '바로주문'
                                ),
                                GestureDetector(
                                  child: Icon(Icons.shopping_cart),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child:  Image.asset('images/goodstestimage.png'),
                          ),
                          Text('맛있는 개껌'),
                          Text('30,000원'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),


    );
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
