import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playandroid_flutter/util/hint_util.dart';

class HomeBanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomeBannerState();
  }
}

class _HomeBannerState extends State<HomeBanner> {
  PageController _pageController;
  Timer _timer;
  final listTitle=[
    "title1",
    "title2",
    "title3",
    "title4",
  ];

  int realIndex = 0;
  int virtualIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _pageController.animateToPage(
        realIndex + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(color: Colors.grey),
      child: Stack(
        alignment: Alignment.bottomCenter,// _buildHint控件处于底部位置
        children: <Widget>[
          PageView(
            children: _buildBanner(),
            controller: _pageController,
            onPageChanged: _onPageChanged,
          ),
           _buildHint(),
        ],
      ),
    );
  }

  List<Widget> _buildBanner() {
    List<Widget> list = [];
    list.add(Image.network(
      "https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png",
      fit: BoxFit.fill,
    ));
    list.add(Image.network(
      "https://www.wanandroid.com/blogimgs/3dc1e641-8397-43ad-b1c8-269817bfc407.png",
      fit: BoxFit.fill,
    ));
    list.add(Image.network(
      "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png",
      fit: BoxFit.fill,
    ));
    list.add(Image.network(
      "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png",
      fit: BoxFit.fill,
    ));
    list.add(Image.network(
      "https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png",
      fit: BoxFit.fill,
    ));
    list.add(Image.network(
      "https://www.wanandroid.com/blogimgs/3dc1e641-8397-43ad-b1c8-269817bfc407.png",
      fit: BoxFit.fill,
    ));
    return list;
  }

  _onPageChanged(index) {
    realIndex = index;
    int count = listTitle.length;
    if(index==0){
      virtualIndex=count-1;
      _pageController.jumpToPage(count);
    }else if(index==count+1){
      virtualIndex=0;
      _pageController.jumpToPage(1);
    }else{
      virtualIndex=index-1;
    }
    setState(() {});
  }

  Widget _buildHint(){
     return Container(
       decoration: BoxDecoration(color: Color(0x9940000000)),
       height: 40,
       child: Row(
         children: <Widget>[
           Container(
             padding: EdgeInsets.only(left: 10),
             child:  Text(listTitle[virtualIndex],style: TextStyle(color: Colors.white),),
           ),
           Expanded(
             child: Container(
               padding: EdgeInsets.only(right: 10),
               child: Text("${virtualIndex+1}/${listTitle.length}",style: TextStyle(color: Colors.white),textAlign: TextAlign.end,),
             )
           )
         ],
       ),
     );

  }
}
