//icon | String	| NonNull
//moreUrl | String	|	NonNull
//bigCard1 | Object	|	NonNull
//bigCard2 | Object	|	NonNull
//smallCard1 | Object	|	NonNull
//smallCard2 | Object	|	NonNull
//smallCard3 | Object	|	NonNull
//smallCard4 | Object	|	NonNull
import 'package:flutter_xiecheng/model/common_model.dart';

class SalesBoxModel {
  final String icon;
  final String moreUrl;
  final CommonModel bigCard1;
  final CommonModel bigCard2;
  final CommonModel smallCard1;
  final CommonModel smallCard2;
  final CommonModel smallCard3;
  final CommonModel smallCard4;

  SalesBoxModel(
      {this.icon,
      this.moreUrl,
      this.bigCard1,
      this.bigCard2,
      this.smallCard1,
      this.smallCard2,
      this.smallCard3,
      this.smallCard4});

  factory SalesBoxModel.fromJson(Map<String, dynamic> json) {
    return SalesBoxModel(
      icon: json['icon'],
      moreUrl: json['moreUrl'],
      bigCard1: CommonModel.fromJson(json['bigCard1']),
      bigCard2: CommonModel.fromJson(json['bigCard2']),
      smallCard1: CommonModel.fromJson(json['smallCard1']),
      smallCard2: CommonModel.fromJson(json['smallCard2']),
      smallCard3: CommonModel.fromJson(json['smallCard3']),
      smallCard4: CommonModel.fromJson(json['smallCard4']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['moreUrl'] = this.moreUrl;
    data['bigCard1'] = this.bigCard1;
    data['bigCard2'] = this.bigCard2;
    data['smallCard1'] = this.smallCard1;
    data['smallCard2'] = this.smallCard2;
    data['smallCard3'] = this.smallCard3;
    data['smallCard4'] = this.smallCard4;
    return data;
  }
}
