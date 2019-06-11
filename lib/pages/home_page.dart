import 'dart:async';

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
import 'package:flutter_xiecheng/widgets/loading_container.dart';
import 'package:flutter_xiecheng/widgets/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController(initialPage: 0);
  bool _loading = true;
  double appBarAlpha = 0;
  var resultString = '';
  List<CommonModel> localNavList;
  var subNavList;
  GridNavModel gridNavModel;
  var salesBox;
  List<CommonModel> bannerList;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoadingContainer(
        child: Scaffold(
            body: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: RefreshIndicator(
                    child: NotificationListener(
                      onNotification: (scrollNotificationListener) {
                        if (scrollNotificationListener
                                is ScrollUpdateNotification &&
                            scrollNotificationListener.depth == 0) {
                          _onScroll(scrollNotificationListener.metrics.pixels);
                        }
                      },
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 160,
                            child: Swiper(
                              itemCount: bannerList?.length,
                              autoplay: true,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      CommonModel model = bannerList[index];
                                      return WebView(
                                        url: model.url,
                                        title: model.title,
                                        hideAppBar: model.hideAppBar,
                                      );
                                    }));
                                  },
                                  child: Image.network(
                                    bannerList[index].icon,
                                    fit: BoxFit.fill,
                                  ),
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
                    ),
                    onRefresh: _handleRefresh))),
        isLoading: _loading);
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

  Future<Null> _handleRefresh() async {
    try {
      var homeModel = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(homeModel);
        localNavList = homeModel.localNavList;
        gridNavModel = homeModel.gridNav;
        subNavList = homeModel.subNavList;
        salesBox = homeModel.salesBox;
        bannerList = homeModel.bannerList;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
        _loading = true;
      });
    }
    return null;
  }
}
