

import 'http_util.dart';

class Apis{
  static Future knowledgeTree(){
    return HttpUtil.gets("tree/json");
  }

 static Future navigation(){
    return HttpUtil.gets("navi/json");
 }

  static Future projectChapters() {
    return HttpUtil.gets('project/tree/json');
  }

  /***
   * 这个方法返回了一个带有页码的函数
   */
 static Function chapterArticles(String chapterId){
    return (int pageNo){
      return HttpUtil.gets("wxarticle/list/$chapterId/$pageNo/json");
    };
 }
}