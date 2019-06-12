import 'dart:async';
import 'dart:convert';
import 'package:flutter_xiecheng/model/home_model.dart';
import 'package:flutter_xiecheng/model/search_model.dart';
import 'package:http/http.dart' as http;

class SearchDao {
  static Future<SearchModel> fetch(String url, String keyword) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel searchModel = SearchModel.fromJson(result);
      searchModel.keyword = keyword;
      return searchModel;
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}
