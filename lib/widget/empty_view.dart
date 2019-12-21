import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "暂无数据  o(╥﹏╥)o",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "点击重试",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
