import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/widgets/webview.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  final PageController _pageViewController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: WebView(
      url: 'https://m.ctrip.com/webapp/myctrip/',
      hideAppBar: true,
      backForbid: true,
      statusBarColor: '4c5bca',
    ));
  }
}
