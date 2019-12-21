import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playandroid_flutter/config/colors.dart';
import 'package:playandroid_flutter/config/status.dart';
import 'package:playandroid_flutter/util/apis.dart';
import 'package:playandroid_flutter/util/hint_util.dart';
import 'package:playandroid_flutter/widget/empty_view.dart';
import 'package:playandroid_flutter/widget/error_view.dart';
import 'package:playandroid_flutter/widget/loading_view.dart';
import 'package:playandroid_flutter/widget/refreshable_list.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NavigationPageState();
  }
}

class _NavigationPageState extends State<NavigationPage> {
  List<dynamic> _data;
  Status _status = Status.Loading; //默认是loading状态
  int _selectIndex = 0;
  BuildContext context;
  RefreshableList rightView;
  List<int> rightItemHeights=List();
//  final _dataList = [
//    "Drawable",
//    "deep link",
//    "Drawable",
//    "deep link",
//    "Drawable",
//    "deep link",
//    "Drawable",
//    "deep link"
//  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    Apis.navigation().then((result) {
      _data = result;
      setState(() {
        _status = Status.Success;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    switch (_status) {
      case Status.Empty:
        return EmptyView();
        break;
      case Status.Error:
        return ErrorView(getData());
        break;
      case Status.Loading:
        return LoadingView();
        break;
      case Status.Success:
        if (rightView == null) {
          rightView = RightView();
        }
        return Row(
          children: <Widget>[
            Container(
              width: 100,
              child: LeftView(),
            ),
            Expanded(
              child: rightView,
            )
          ],
        );
      case Status.Loading:
        break;
      case Status.Error:
        break;
      case Status.Empty:
        break;
    }
  }

  Widget LeftView() {
    return RefreshableList(
      [_data],
      _buildItem,
      showFloating: false,
    );
  }

//左边的View
  Widget _buildItem(dynamic item, int index) {
    return InkWell(
      onTap: () {
        rightView.jumpTo(getJumpHeight(index));
        setState(() {
          _selectIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Text(
            item["name"],
            style: TextStyle(
                fontSize: 14,
                color: index == _selectIndex ? Colors.blue : Colors.grey,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  //右边的View
  Widget RightView() {
    return RefreshableList(
      [_data],
      _buildRightItem,
      showFloating: false,
      divider: () {
        return Container(height: 10);
      },
    );
  }

  Widget _buildRightItem(dynamic item, int index) {
    var factor=item["articles"].length>8?13:30;
    rightItemHeights.add(20+item["articles"].length*factor);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item["name"],
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Color(0x6FECEFF6),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            padding: EdgeInsets.all(10),
            child: Wrap(
              children: item["articles"].map<Widget>((dynamic item) {
                Color color = tagColors[Random().nextInt(tagColors.length - 1)];
                return InkWell(
                  onTap: () {
                    HintUtil.toast(context, item["title"]);
                  },
                  child: Text(
                    item["title"],
                    style: TextStyle(color: color),
                  ),
                );
              }).toList(),
              spacing: 10, //左右间距
              runSpacing: 10, //上下间距
            ),
          )
        ],
      ),
    );
  }

  /***
   * 模拟计算高度
   */
  double getJumpHeight(int index) {
    double result=0.0;
    for(int i=0;i<index;i++){
      result+=rightItemHeights[i];
    }
    return result;
  }
}
