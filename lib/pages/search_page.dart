import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/dao/search_dao.dart';
import 'package:flutter_xiecheng/widgets/search_bar.dart';
import 'package:flutter_xiecheng/model/search_model.dart';

const SEARCH_URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String keyword;
  final String hint;
  final String searchUrl;

  const SearchPage(
      {Key key,
      this.hideLeft,
      this.keyword,
      this.hint,
      this.searchUrl = SEARCH_URL})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PageController _pageViewController = PageController(initialPage: 0);
  SearchModel searchModel;
  String keyword;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
      children: <Widget>[
        _appBar(),
        Expanded(
          flex: 1,
          child: ListView.builder(
              itemCount: searchModel?.data?.length ?? 0,
              itemBuilder: (BuildContext context, int position) {
                return _item(position);
              }),
        ),
      ],
    ));
  }

  void _onTextChange(String text) {
    keyword = text;
    print('_onTextChange=' + keyword);
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl + keyword;
    SearchDao.fetch(url,text).then((SearchModel model) {
      if(model.keyword == keyword){
        setState(() {
          searchModel = model;
        });
      }

    }).catchError((e) {
      print(e);
    });
  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  Widget _item(int position) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[position];
    return Text(item.word);
  }
}
