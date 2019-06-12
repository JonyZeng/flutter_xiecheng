import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PageController _pageViewController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body:Column(
        children: <Widget>[
          SearchBar(
             hideLeft: true,
            defaultText: '哈哈',
            hint: '134',
            leftButtonClick: (){
               Navigator.pop(context);
            },
            onChanged: _onTextChange,
          )
        ],
      )
    );
  }

  void _onTextChange(String value) {
  }
}
