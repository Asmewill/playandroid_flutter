import 'package:flutter/material.dart';
import 'package:playandroid_flutter/util/hint_util.dart';

class ArticleItemView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleItemViewState();
  }
}

class _ArticleItemViewState extends State<ArticleItemView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HintUtil.toast(context, "item");
      },
      child: Container(
        padding: EdgeInsets.only(top: 10,left: 10,bottom: 10,right: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("author"),
                Expanded(
                    //沾满余下的空位置
                    child: Container(
                  child: Text(
                    "2019-12-08",
                    textAlign: TextAlign.right,
                  ),
                ))
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Image.network(
                    "https://wanandroid.com/blogimgs/2baa4b4b-acfe-473c-b534-9d672423e564.png",
                    width: 120,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10,bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "一个模仿企鹅的FM 界面的APP，一个模仿企鹅的FM 界面的APP",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "一个模仿企鹅的FM 界面的APP，一个模仿企鹅的FM 界面的APP,一个模仿企鹅的FM 界面的APP",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: Text("开源项目主Tab/完整项目")),
                Container(
                  height: 24,
                  padding: EdgeInsets.only(right: 0),
                  //decoration: BoxDecoration(color: Colors.grey),
                  alignment: Alignment.topRight,
                  child: IconButton(
                     padding: EdgeInsets.all(0),
                      icon: Icon(Icons.stars, color: Colors.grey),
                      alignment: Alignment.centerRight,
                      onPressed: () {
                        HintUtil.toast(context, "collect");
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
