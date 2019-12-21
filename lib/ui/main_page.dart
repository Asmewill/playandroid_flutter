import 'package:flutter/material.dart';
import 'package:playandroid_flutter/ui/project_page.dart';
import 'package:playandroid_flutter/ui/wechat_page.dart';
import 'package:playandroid_flutter/util/hint_util.dart';
import 'package:playandroid_flutter/util/image_util.dart';

import 'drawer_page.dart';
import 'home_page.dart';
import 'knowledge_tree_page.dart';
import 'navigation_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  var _selectedIndex = 0; //页面索引值
  PageController _pageController; //页面控制器
  List<BottomNavigationBarItem> bottomItemList;
  DateTime lastBackTime = DateTime.now();
  final _bottomItems = [
    _Item("首页", "ic_home"),
    _Item("公众号", "ic_wechat"),
    _Item("项目", "ic_project"),
    _Item("网站导航", "ic_navigation"),
    _Item("知识体系", "ic_dashboard")
  ];

  final _pages=[
    HomePage(),
    WeChatPage(),
    ProjectPage(),
    NavigationPage(),
    KnowledgeTreePage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    if (bottomItemList == null) {
      //使用map变换类型
      bottomItemList = _bottomItems
          .map((item) => BottomNavigationBarItem(
              icon: Image.asset(
                ImageUtil.getImagePath(item.icon),
                color: Colors.grey,
                width: 25,
                height: 25,
              ),
              title: Text(
                item.name,
                style: TextStyle(fontSize: 16),
              ),
              activeIcon: Image.asset(
                ImageUtil.getImagePath(item.icon),
                color: Colors.green,
                width: 25,
                height: 25,
              )))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
        drawer: Drawer(
          child: DrawerPage(),
        ),
        appBar: AppBar(
          title: Text(_selectedIndex == 0
              ? "玩安卓"
              : _bottomItems.elementAt(_selectedIndex).name),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                HintUtil.toast(context, "search...");
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomItemList,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed, //这个类型很重要，一定要设置
          onTap: (int index){
            setState(() {
              _selectedIndex=index;
              _pageController.jumpToPage(_selectedIndex);//对页面进行切换
            });

          },
        ),
        body:PageView(
          children: _pages,
          controller: _pageController,
          physics:NeverScrollableScrollPhysics()//静止左右切换滑动
        )
      ),
      onWillPop: () {
        DateTime timeNow = DateTime.now();
        if (timeNow.difference(lastBackTime).inSeconds > 1) {
          HintUtil.toast(context, "在按一次退出...");
          lastBackTime = timeNow;
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
    );
  }
}

class _Item {
  String name, icon;
  _Item(this.name, this.icon);
}
