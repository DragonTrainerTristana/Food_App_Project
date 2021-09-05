import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_service_application/GoodsInfo.dart';
import 'package:pet_service_application/SeungHyun/screen/DetailedGoodsScreen.dart';

class BargainCardWidget extends StatefulWidget {
  final GoodsInfo goodsInfo;  //굿즈 정보 객체

  BargainCardWidget({Key? key, required this.goodsInfo}) : super(key: key); //생성자

  @override
  _BargainCardWidget createState() => _BargainCardWidget(); //위젯 생성
}

class _BargainCardWidget extends State<BargainCardWidget> {
  final BorderRadius _baseBorderRadius = BorderRadius.circular(20); //테두리 반지름

  @override
  Widget build(BuildContext context) {
    final heartAndCartSize = MediaQuery.of(context).size.width * 0.04;  //좋아요,장바구니 아이콘 크기
    const double GoodsNameSize = 20;

    return GestureDetector(
      onTap: () {
        /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailedGoodsScreen(widget.goodsInfo)));  */ //터치시 굿즈 디테일 창으로 이동
      },
      child: Card(
        elevation: 5,   //그림자
        semanticContainer: true,
        margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: _baseBorderRadius),
        clipBehavior: Clip.antiAliasWithSaveLayer,

        child: Row(
          children: [
            Container(
              width: heartAndCartSize * 5,
              height: heartAndCartSize * 5,

              child: Image.network(widget.goodsInfo.imgUrl),
            ),  //상품 이미지
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(widget.goodsInfo.name)
                ),  //커뮤니티 제목(임시로 상품이름)
                Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                        widget.goodsInfo.name,
                      style: TextStyle(
                        fontSize: GoodsNameSize,
                      ),
                    )
                ),  //상품 이름
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                          margin: EdgeInsets.only(left: 20, top: 5),
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              children: getPriceTextSpan(widget.goodsInfo),
                            ),
                          )),
                    ),  //상품 가격
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: heartAndCartSize,
                        height: heartAndCartSize,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.goodsInfo.detailedInfo.isLike =
                              !widget.goodsInfo.detailedInfo.isLike;
                            });
                          },
                          child: Icon(
                            Icons.favorite,
                            color: widget.goodsInfo.detailedInfo.isLike
                                ? Color.fromRGBO(255, 87, 87, 1)
                                : Color.fromRGBO(217, 217, 217, 1),
                          ),
                        ),  //좋아요 값 변경
                      ),
                    ),  //좋아요
                  ],
                )        //상품 가격과 좋아요
              ],
            )      //상품 정보와 좋아요
          ],
        ),
      ),
    );
  }

  List<TextSpan> getPriceTextSpan(GoodsInfo goodsInfo) {
    List<TextSpan> priceTextSpan = [];
    if (goodsInfo.discountedPrice == null) {
      priceTextSpan.add(
        TextSpan(
          text: NumberFormat('###,###,###,###')
              .format(goodsInfo.price)
              .replaceAll(' ', '') +
              '원',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      );
    } else {
      priceTextSpan.add(
        TextSpan(
          text: (NumberFormat('###,###,###,###')
              .format(goodsInfo.price)
              .replaceAll(' ', '')),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(175, 173, 173, 1),
            decoration: TextDecoration.lineThrough,
          ),
        ),
      );
      priceTextSpan.add(
        TextSpan(
          text: ' ' +
              (NumberFormat('###,###,###,###')
                  .format(goodsInfo.discountedPrice)
                  .replaceAll(' ', '') +
                  '원'),
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 87, 87, 1)),
        ),
      );
    }

    return priceTextSpan;
  } //상품 가격 불러오는 함수
}