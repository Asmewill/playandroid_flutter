

import 'package:flutter/material.dart';
import 'package:playandroid_flutter/util/apis.dart';
import 'package:playandroid_flutter/widget/article_item_view.dart';
import 'package:playandroid_flutter/widget/refreshable_list.dart';

class ArticleTabPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return  _ArticleTabPageState();
  }
}
class _ArticleTabPageState extends State<ArticleTabPage>{
  List<String> _dateList=[
    "完整项目",
    "完整项目",
    "完整项目",
    "完整项目",
    "完整项目",
    "完整项目",
    "完整项目",
    "完整项目",
    "完整项目"
  ];
  List<dynamic> _dataList=List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length:_dateList.length ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: TabBar(
              tabs: _dateList.map<Widget>((String item){
                     return Tab(text: item);
              }).toList(),
              isScrollable: true,//tab是否可以滑动
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,//设置底部tab宽度大小
              labelStyle: TextStyle(fontSize: 16),
              labelColor: Colors.white,
            ),
          ),
          Expanded(
            child: TabBarView(
                children: _dateList.map<Widget>(_buildPage).toList()
            ),
          )
        ],
      ),

    );
  }

  Widget _buildPage(String e) {
      return RefreshableList(
        [],
        _buildItem,
        showFloating: false,
      );
  }

 Widget _buildItem(dynamic item,int index) {
    return ArticleItemView();
 }

  void getData() {
    Apis.projectChapters().then((result){

    });
  }
}