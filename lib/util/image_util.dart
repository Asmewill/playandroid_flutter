import 'package:flutter/material.dart';

class ImageUtil{
  static String getImagePath(String name,{String format:'png'}){
    return 'assets/images/$name.$format';
  }

  static Widget getRoundImage(String imgName,double radius,{String format:'png'}){
    return _getRoundImage(imgName,radius,0,format);

  }

  static Widget _getRoundImage(String imgName,double radius,int type,String format) {
    switch(type){
      case 0:
        return CircleAvatar(
          backgroundImage: AssetImage(getImagePath(imgName,format: format)),
          radius: radius,
        );
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;

    }
  }
}