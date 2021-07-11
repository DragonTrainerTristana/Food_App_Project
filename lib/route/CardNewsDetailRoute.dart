import 'package:flutter/material.dart';
import 'package:pet_service_application/card_news/CardNewsModel.dart';
import 'package:pet_service_application/appbar/DrawerWithAlarmAppBar.dart';
import 'package:pet_service_application/card_news/detail/CardNewsRelatedProductsWidget.dart';
import 'package:pet_service_application/card_news/detail/DetailCardNews.dart';
import 'package:pet_service_application/card_news/detail/EventDetailWidget.dart';
import 'package:pet_service_application/card_news/detail/TopPetsWidget.dart';

class CardNewsDetailRoute extends StatelessWidget {
  final CardNewsModel cardNewsModel;

  CardNewsDetailRoute(this.cardNewsModel);

  @override
  Widget build(BuildContext context) {
    DetailCardNewsPageView detailCardNewsPageView = DetailCardNewsPageView(
        detailCardNewsModelList: cardNewsModel.detailCardNewsModelList!);

    return Scaffold(
      body: Column(
        children: [
          DrawerWithAlarmAppBar(nickName: '닉네임'),
          Expanded(
              child: ListView(children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.all(35),
                child: Text(
                  cardNewsModel.title,
                  style: TextStyle(
                      fontSize: 27.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                )),
            Container(
              height: MediaQuery.of(context).size.width *
                  detailCardNewsPageView.getViewPortFractionValue(),
              child: detailCardNewsPageView,
            ),
            cardNewsModel.type == CardNewsType.CARDNEWS
                ? CardNewsRelatedProductsWidget(cardNewsModel.goodsInfoList)
                : cardNewsModel.type == CardNewsType.EVENT
                    ? SpecialCouponWidget()
                    : cardNewsModel.type == CardNewsType.TOPPET
                        ? TopPetsWidget()
                        : Container(),
          ])),
          // TextField -> 댓글 입력 및 버튼
          // 댓글 리스트
        ],
      ),
    );
  }
}
