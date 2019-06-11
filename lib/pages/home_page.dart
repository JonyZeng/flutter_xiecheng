import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_xiecheng/dao/home_dao.dart';
import 'dart:convert';

import 'package:flutter_xiecheng/model/common_model.dart';
import 'package:flutter_xiecheng/model/grid_nav_model.dart';
import 'package:flutter_xiecheng/widgets/grid_nav.dart';
import 'package:flutter_xiecheng/widgets/local_nav.dart';
import 'package:flutter_xiecheng/widgets/sales_box.dart';
import 'package:flutter_xiecheng/widgets/sub_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController(initialPage: 0);

  List _imageUrls = [
    'http://www.devio.org/io/flutter_app/img/banner/100h10000000q7ght9352.jpg',
    'https://dimg04.c-ctrip.com/images/300h0u000000j05rnD96B_C_500_280.jpg',
    'http://pages.ctrip.com/hotel/201811/jdsc_640es_tab1.jpg',
    'https://dimg03.c-ctrip.com/images/fd/tg/g1/M03/7E/19/CghzfVWw6OaACaJXABqNWv6ecpw824_C_500_280_Q90.jpg',
  ];
  double appBarAlpha = 0;
  var resultString = '';
  List<CommonModel> localNavList;
  var subNavList;
  GridNavModel gridNavModel;
  var salesBox;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotificationListener) {
                if (scrollNotificationListener is ScrollUpdateNotification &&
                    scrollNotificationListener.depth == 0) {
                  _onScroll(scrollNotificationListener.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.fill,
                        );
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Padding(
                    child: LocalNav(
                      localNavList: localNavList,
                    ),
                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                  ),
                  Padding(
                    child: GridNav(
                      gridNavModel: gridNavModel,
                    ),
                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                  ),
                  Padding(
                    child: SubNav(subNavList: subNavList),
                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                  ),
                  Padding(
                    child: SalesBox(
                      salesBox: salesBox,
                    ),
                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text('test'),
                    ),
                  )
                ],
              ),
            )));
  }

  void _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 0) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  void loadData() async {
    try {
      var homeModel = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(homeModel);
        localNavList = homeModel.localNavList;
        gridNavModel = homeModel.gridNav;
        subNavList = homeModel.subNavList;
        salesBox = homeModel.salesBox;
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
      });
    }
  }
}
