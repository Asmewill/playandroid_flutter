import 'package:flutter/material.dart';
import 'package:playandroid_flutter/widget/article_item_view.dart';
import 'package:playandroid_flutter/widget/home_banner.dart';
import 'package:playandroid_flutter/widget/refreshable_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshableList([], _buildItem, //变量就是一个函数
        divider: _deviderItem);
  }

  Widget _buildItem(int index) {
    if (index == 0) {
      return HomeBanner();
    } else {
      return ArticleItemView();
    }
  }

  Widget _deviderItem() {
    return Container(
      color: Colors.grey,
      height: 0.2,
    );
  }
}
