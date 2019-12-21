import 'dart:convert';

import 'package:http/http.dart';
import 'package:playandroid_flutter/util/hint_util.dart';
import 'package:playandroid_flutter/util/account_util.dart';

const BASE_URL = "https://www.wanandroid.com";

String getResultUrl(String path) {
  return "$BASE_URL/$path";
}


Future<Map> getHeader() async {
  Map<String, String> headers = Map();
  String cookie = await AccountUtil.getCookie();
  headers["Cookie"] = cookie;
  return headers;
}

Future processResponse(String url,Future<Response> future){
  return future.then((Response response){
      if(response.statusCode==200){
          var jsonResponse=jsonDecode(response.body);
          //设置Cookie值，后续弄登录时在添加
          if(url.contains("user/login")){
          }
          return Future.value(jsonResponse);
      }else{
         var msg="请求失败${response.statusCode}";
         HintUtil.log(msg);
         return Future.error(msg);
      }
  }).then((jsonResponse){
    HintUtil.log("$url json返回如下:\n $jsonResponse");
    if(jsonResponse!=null){
      if(jsonResponse['errorCode']==0){
        return jsonResponse['data'];
      }else{
        var msg="业务失败:${jsonResponse['errorMsg']}";
        HintUtil.log(msg);
        return Future.error(msg);
      }
    }
  });

}

class HttpUtil {
  static Future gets(String path) async {
    var url = getResultUrl(path);
    var headers = await getHeader();
    HintUtil.log("get请求:$url\n请求头:$headers");
    return  processResponse(url, get(url,headers:headers));
  }
}
