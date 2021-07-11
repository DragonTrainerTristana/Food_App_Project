import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_service_application/SeungHyun/screen/DetailedGoodsScreen.dart';
import 'package:pet_service_application/appbar/DrawerWithAlarmAppBar.dart';
import 'package:intl/intl.dart';
import 'package:pet_service_application/bottombar/MenuBottomBar.dart';

class GoodsScreen extends StatefulWidget {
  @override
  _GoodsScreen createState() => _GoodsScreen();
}

class _GoodsScreen extends State<GoodsScreen> {
  FilterTabWithListView filterTabWithListView = FilterTabWithListView(
    goodsItemModelList: [
      GoodsItemModel('img', '피부모질 닥터독 사료 2kg', 29500, null),
      GoodsItemModel('img', '피부모질 닥터독 사료 2kg', 29500, null),
      GoodsItemModel('img', '피부모질 닥터독 사료 2kg', 29500, 26500),
      GoodsItemModel('img', '피부모질 닥터독 사료 2kg', 29500, null),
      GoodsItemModel('img', '피부모질 닥터독 사료 2kg', 29500, 18000),
      GoodsItemModel('img', '피부모질 닥터독 사료 2kg', 29500, 20000),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DrawerWithAlarmAppBar(nickName: '닉네임'),
          SearchBar(
            filterTabWithListView: filterTabWithListView,
          ),
          Container(
            margin: EdgeInsets.only(top: 25, left: 35, right: 35),
            child: Divider(
              color: Color.fromRGBO(0, 0, 0, 0.3),
              height: 20,
              thickness: 1.5,
              indent: 15,
              endIndent: 15,
            ),
          ),
          Expanded(
            child: filterTabWithListView,
          ),
          Container(child: MenuBottomBar()),
        ],
      ),
    );
  }
/*        child: SearchBar<Food>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getALlFoods,

          searchBarController: _searchBarController,

          placeHolder: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      goodscard(),
                      goodscard(),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      goodscard(),
                      goodscard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //cancellationWidget: Text("Cancel"),
          emptyWidget: Text("empty"),
          /*
          indexedScaledTileBuilder: (int index) =>
              ScaledTile.count(1, index.isEven ? 2 : 1),

          minimumChars: 1,*/
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          header: Container(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(12)),
                Container(
                  height: 1.0,
                  width: 500.0,
                  color: Colors.black,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          setState(() {
                            a++;
                            if (a % 2 == 0) {
                              _price = '가격낮은순';
                            } else {
                              _price = '가격높은순';
                            }
                          });
                          if (a % 2 == 0) {
                            /*_searchBarController.sortList((Food a, Food b) {
                              return a.price.compareTo(b.price);
                            });*/
                          } else {
                            // _searchBarController.removeSort();
                          }
                        },
                        child: Text(_price),
                      ),
                      Padding(padding: EdgeInsets.all(32)),
                      Text('리뷰많은순'),
                      Padding(padding: EdgeInsets.all(32)),
                      Text('인기순'),
                      Padding(padding: EdgeInsets.all(32)),
                      Text('종류'),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(0)),
              ],
            ),
          ),
          onItemFound: (Food food, int index) {
            return Column(
              children: <Widget>[
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: SizedBox(
                      height: 220,
                      width: 220,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailedGoodsScreen()));
                        },
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Icon(Icons.favorite),
                                    ),
                                    Text('바로주문'),
                                    GestureDetector(
                                      child: Icon(Icons.shopping_cart),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.asset('images/goodstestimage.png'),
                              ),
                              Text(food.title),
                              Text('${food.price}원'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),*/
}

enum GoodsFilterType { PRICE, REVIEW, POPULARITY, CATEGORY }

class SearchBar extends StatelessWidget {
  final FilterTabWithListView filterTabWithListView;
  SearchBar({Key? key, required this.filterTabWithListView}) : super(key: key);

  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.only(left: 50, top: 20, right: 50),
        child: Container(
          child: Row(
            children: [
              SizedBox(
                height: 50,
                width: 60,
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: textFieldController,
                  style: TextStyle(
                      fontSize: 17, color: Color.fromRGBO(0, 0, 0, 0.5)),
                  cursorColor: Color.fromRGBO(217, 217, 217, 1),
                  onChanged: (text) {
                    filterTabWithListView
                        .createState()
                        .goodsItemListView!
                        .getStateData()
                        .applySearchData(text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoodsItemModel {
  String imgUrl;
  String productName;
  int price;
  int? discountedPrice;

  GoodsItemModel(
      this.imgUrl, this.productName, this.price, this.discountedPrice);
}

class FilterTabWidget extends StatefulWidget {
  final GoodsFilterType goodsFilterType;
  final EdgeInsetsGeometry margin;
  final int flex;
  final String tabName;
  final Function() onTapEvent;

  final TextStyle selectedTextStyle = TextStyle(
          fontSize: 13.0, color: Colors.black, fontWeight: FontWeight.bold),
      unSelectedTextStyle =
          TextStyle(fontSize: 13.0, color: Color.fromRGBO(0, 0, 0, 0.5));

  FilterTabWidget({
    Key? key,
    required this.goodsFilterType,
    required this.margin,
    required this.flex,
    required this.tabName,
    required this.onTapEvent,
  }) : super(key: key);

  final _FilterTabWidget getStateData = _FilterTabWidget();

  @override
  _FilterTabWidget createState() => getStateData;
}

class _FilterTabWidget extends State<FilterTabWidget> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    if (widget.goodsFilterType == GoodsFilterType.PRICE) isSelected = true;
  }

  void refreshTab() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
            onTap: () {
              widget.onTapEvent();
            },
            child: Container(
                margin: widget.margin,
                child: Center(
                    child: Text(widget.tabName,
                        style: isSelected
                            ? widget.selectedTextStyle
                            : widget.unSelectedTextStyle)))));
  }
}

class GoodsItemListView extends StatefulWidget {
  final List<GoodsItemModel> goodsItemModelList;

  GoodsItemListView({Key? key, required this.goodsItemModelList})
      : super(key: key);

  final _cardNewsListView = _GoodsItemListView();

  _GoodsItemListView getStateData() => _cardNewsListView;

  @override
  _GoodsItemListView createState() => _cardNewsListView;
}

class _GoodsItemListView extends State<GoodsItemListView> {
  // 부모한테 원본 데이터가 있고, 현재 리스트는 Filtering될 리스트
  List<GoodsItemModel> filteredGoodsItemModelList = [];

  @override
  void initState() {
    super.initState();

    setGoodsItemModelListData(widget.goodsItemModelList);
  }

  void setGoodsItemModelListData(List<GoodsItemModel> _goodsItemDataList) {
    filteredGoodsItemModelList.clear();
    filteredGoodsItemModelList.addAll(_goodsItemDataList);
  }

  void applySearchData(String textFieldData) {
    setGoodsItemModelListData(widget.goodsItemModelList);
    setState(() {
      filteredGoodsItemModelList.removeWhere(
          (element) => !element.productName.contains(textFieldData));
    });
  }

  void changeOriginalData(List<GoodsItemModel> _goodsItemDataList) {
    setState(() {
      setGoodsItemModelListData(_goodsItemDataList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      children: List.generate(
        filteredGoodsItemModelList.length,
        (index) => GoodsItem(
          filteredGoodsItemModelList[index],
        ),
      ),
    );
  }
}

class GoodsItem extends StatefulWidget {
  final GoodsItemModel _goodsItemModel;

  GoodsItem(this._goodsItemModel);

  @override
  _GoodsItem createState() => _GoodsItem();
}

class _GoodsItem extends State<GoodsItem> {
  final BorderRadius _baseBorderRadius = BorderRadius.circular(8);
  final double leftRightMarginSize = 50;

  @override
  Widget build(BuildContext context) {
    final heartAndCartSize = MediaQuery.of(context).size.width * 0.04;

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailedGoodsScreen()));
      },
      child: Card(
        elevation: 5,
        semanticContainer: true,
        margin: EdgeInsets.all(15),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: _baseBorderRadius),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: heartAndCartSize,
                            height: heartAndCartSize,
                            child: Image.asset('images/heart_icon.png'))),
                    Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            '바로주문',
                            style: TextStyle(
                                color: Color.fromRGBO(168, 168, 168, 1)),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            width: heartAndCartSize,
                            height: heartAndCartSize,
                            child: Image.asset('images/cart_icon.png')))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  width: heartAndCartSize * 5,
                  height: heartAndCartSize * 5,
                  child: Image.network(widget._goodsItemModel.imgUrl),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.bottomLeft,
                  child: Text(widget._goodsItemModel.productName)),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      children: getPriceTextSpan(widget._goodsItemModel),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> getPriceTextSpan(GoodsItemModel goodsItemModel) {
    List<TextSpan> priceTextSpan = [];
    if (goodsItemModel.discountedPrice == null) {
      priceTextSpan.add(
        TextSpan(
          text: NumberFormat('###,###,###,###')
                  .format(goodsItemModel.price)
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
              .format(goodsItemModel.price)
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
                      .format(goodsItemModel.discountedPrice)
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
  }
}

class FilterTabWithListView extends StatefulWidget {
  final List<GoodsItemModel> goodsItemModelList;

  FilterTabWithListView({Key? key, required this.goodsItemModelList})
      : super(key: key);
  final _FilterTabWithListView _filterTabWithListView =
      _FilterTabWithListView();

  _FilterTabWithListView getStateData() => _filterTabWithListView;

  @override
  _FilterTabWithListView createState() => _FilterTabWithListView();
}

class _FilterTabWithListView extends State<FilterTabWithListView> {
  List<FilterTabWidget> filterTabList = [];
  List<GoodsItemModel> filteredCardNewsModelList = [];
  GoodsItemListView? goodsItemListView;
  List<String> tabName = ['가격낮은순 ▼', '리뷰많은순 ▼', '인기순 ▼', '종류 ▼'];

  @override
  void initState() {
    super.initState();

    _initUIWidgets();
  }

  void changeTabName(int index, String tabName1, String tabName2) {
    setState(() {
      if (tabName[0] == tabName1)
        tabName[0] = tabName2;
      else
        tabName[0] = tabName1;
    });
  }

  void _initUIWidgets() {
    goodsItemListView =
        GoodsItemListView(goodsItemModelList: widget.goodsItemModelList);

    filterTabList.clear();

    filterTabList.addAll([
      FilterTabWidget(
          goodsFilterType: GoodsFilterType.PRICE,
          margin: EdgeInsets.only(
            left: 25,
            right: 10,
            top: 10,
            bottom: 25,
          ),
          flex: 1,
          tabName: tabName[0],
          onTapEvent: () {
            _manageFilterTabWidget(0);
            changeTabName(0, '가격낮은순 ▼', '가격높은순 ▲');
          }),
      FilterTabWidget(
          goodsFilterType: GoodsFilterType.REVIEW,
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 25,
          ),
          flex: 1,
          tabName: tabName[1],
          onTapEvent: () {
            _manageFilterTabWidget(1);
            changeTabName(1, '리뷰많은순 ▼', '리뷰적은순 ▲');
          }),
      FilterTabWidget(
          goodsFilterType: GoodsFilterType.POPULARITY,
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 25,
          ),
          flex: 1,
          tabName: tabName[2],
          onTapEvent: () {
            _manageFilterTabWidget(2);
            changeTabName(2, '인기순 ▼', '인기순 ▲');
          }),
      FilterTabWidget(
          goodsFilterType: GoodsFilterType.CATEGORY,
          margin: EdgeInsets.only(
            left: 10,
            right: 25,
            top: 10,
            bottom: 25,
          ),
          flex: 1,
          tabName: tabName[3],
          onTapEvent: () {
            _manageFilterTabWidget(3);
            changeTabName(3, '종류 ▼', '종류 ▲');
          }),
    ]);
  }

  void _manageFilterTabWidget(int index) {
    filterTabList[index].getStateData.refreshTab();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: filterTabList,
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: goodsItemListView!,
            ),
          ),
        ],
      ),
    );
  }
}
