import 'package:flutter/material.dart';
import 'package:playandroid_flutter/util/hint_util.dart';

class ErrorView extends StatelessWidget {
  Function retry;
  ErrorView(this.retry);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: retry,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "加载失败,o(╥﹏╥)o",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "点击重试",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
