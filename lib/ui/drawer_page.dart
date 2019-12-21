import 'package:flutter/material.dart';
import 'package:playandroid_flutter/util/hint_util.dart';
import 'package:playandroid_flutter/util/image_util.dart';
import 'package:playandroid_flutter/util/nav_util.dart';

class DrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _DrawerPageState();
  }
}

class _DrawerPageState extends State<DrawerPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
            color: Theme.of(context).primaryColor,
            height: 180,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImageUtil.getRoundImage("ic_avatar", 40),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "您还没有登录...",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )),
        Expanded(
            child: ListView(
          children: <Widget>[
            getItem("ic_favorite_not", "收藏夹", () {
              HintUtil.toast(context, "收藏夹");
            }),
            getItem("ic_todo", "任务清单", () {
              HintUtil.toast(context, "任务清单");
            }),
            getItem("ic_about", "关于", () {
              HintUtil.toast(context, "关于");
            }),
           getLogout()
          ],
        ))
      ],
    );
  }

  Widget getItem(String imgName, String title, Function onTap) {
    return ListTile(
      leading: Image.asset(
        ImageUtil.getImagePath(imgName),
        width: 20,
        height: 20,
        color: Colors.black45,
      ),
      title: Text(title),
      onTap: onTap,
    );
  }

 Widget getLogout() {
    return  getItem("ic_logout","退出登录",(){
      HintUtil.alert(context, "退出登录", "确定要退出登录", (){
        HintUtil.toast(context, "sure");
        NavUtil.pop(context);

      }, (){
        HintUtil.toast(context, "cancel");
        NavUtil.pop(context);
      });

    });
 }
}
