import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playandroid_flutter/config/colors.dart';
import 'package:playandroid_flutter/util/Apis.dart';
import 'package:playandroid_flutter/util/hint_util.dart';
import 'package:playandroid_flutter/widget/refreshable_list.dart';

class KnowledgeTreePage extends StatelessWidget {
  BuildContext _context;
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
  Widget build(BuildContext context) {
    this._context = context;
    // TODO: implement build
    return RefreshableList(
      [Apis.knowledgeTree()],
      _buildItem,
      divider: _deviderItem,
      showFloating: false,
      refreshable: true,
    );
  }

  Widget _buildItem(dynamic item,int index) {
    return InkWell(
      onTap: () {
        HintUtil.toast(_context,"${item["children"].toString()}");
      },
      child: Container(
        color: Color(0x6FECEFF6),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //从最左边开始
          children: <Widget>[
            Text(
              item["name"],
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Wrap( //相当于Flowlayout
                children: item['children'].map<Widget>(
                        (dynamic childItem) {
                          Color randomColor=tagColors.elementAt(Random().nextInt(tagColors.length-1));
                      return Text(childItem["name"], style: TextStyle(color:randomColor),);
                    }
                ).toList(),
                runSpacing: 10, //上下行间距
                spacing: 10, //左右间距
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _deviderItem() {
    return Container(
      height: 10,
    );
  }
}
