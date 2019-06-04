import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController(initialPage: 0);
  List _imageUrls = [
    'https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p20877.jpg',
    'https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p11871.jpg',
    'https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1477066064.22.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 160,
              child: Swiper(itemCount: _imageUrls.length,
              autoplay: true,
                itemBuilder: (BuildContext context,int index){
                return Image.network(
                  _imageUrls[index],
                  fit: BoxFit.cover,
                );
                },
                pagination: SwiperPagination(
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
